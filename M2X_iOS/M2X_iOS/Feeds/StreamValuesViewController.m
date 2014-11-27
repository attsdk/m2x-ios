
#import "StreamValuesViewController.h"
#import "NSDate+M2X.h"

@interface StreamValuesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfNewValue;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreamValues;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;

@property (nonatomic, strong) NSMutableArray *valueList;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation StreamValuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewStreamValues.dataSource = self;
    
    if (![self.streamUnit[@"symbol"] isEqual:[NSNull null]]) {
        self.lblUnit.text = self.streamUnit[@"symbol"];
    }
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableViewStreamValues addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(getStreamValues)
                  forControlEvents:UIControlEventValueChanged];
    
    [self getStreamValues];
}

#pragma mark - request

-(void)getStreamValues
{
    NSLog(@"Getting stream values");
    NSDictionary *parameters = @{ @"limit": @"100" };
    [_deviceClient listDataValuesFromTheStream:_streamName
                                      inDevice:_device_id
                              WithParameters:parameters
                                     completionHandler:^(CBBResponse *response)
    {
        if (response.error) {
            [self.refreshControl endRefreshing];
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[NSString stringWithFormat:@"%@", response.errorObject.localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];

        } else {
            self.valueList = response.json[@"values"];
            [self.tableViewStreamValues reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
    
}

#pragma mark - IBAction

- (IBAction)postValue:(UIButton *)sender
{
    if (![self.tfNewValue.text isEqualToString:@""])
    {
        NSNumber *value = @([self.tfNewValue.text floatValue]);
        NSLog(@"Posting value %@", value);
        sender.enabled = NO;
        [_tfNewValue resignFirstResponder];
        
        NSString *now = [NSDate date].toISO8601;
        NSDictionary *args = @{ @"values": @[
                                        @{ @"value": value, @"timestamp": now }
                                        ]
                                };
        
        [_deviceClient postDataValues:args
                          forStream:_streamName
                             inDevice:_device_id
                            completionHandler:^(CBBResponse *response)
        {
            if (response.error) {
                [self showError:response.errorObject withMessage:response.errorObject.userInfo];
                sender.enabled = YES;
            } else {
                [self getStreamValues];
                self.tfNewValue.text = @"";
                sender.enabled = YES;
            }
        }];
    }
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message
{
    [[[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                message:[NSString stringWithFormat:@"%@", message]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Values";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.valueList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *valueData = self.valueList[indexPath.row];
    NSDate *createdDate = [NSDate fromISO8601:valueData[@"timestamp"]];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", valueData[@"value"], _streamUnit[@"symbol"] ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"at: %@", dateString];
    return cell;
}

@end
