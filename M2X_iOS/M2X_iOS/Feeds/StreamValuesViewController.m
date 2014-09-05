
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
    [_feedClient listDataValuesFromTheStream:_streamName
                                      inFeed:_feed_id
                              WithParameters:parameters
                                     success:^(NSDictionary *object)
    {
        self.valueList = object[@"values"];
        [self.tableViewStreamValues reloadData];
        NSLog(@"%d stream values displayed.", self.valueList.count);
        [self.refreshControl endRefreshing];
    }
                                     failure:^(NSError *error, NSDictionary *message)
    {
        [self.refreshControl endRefreshing];
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"%@", message]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
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
                                        @{ @"value": value, @"at": now }
                                        ]
                                };
        
        [_feedClient postDataValues:args
                          forStream:_streamName
                             inFeed:_feed_id
                            success:^(id object)
        {
            [self getStreamValues];
            self.tfNewValue.text = @"";
            sender.enabled = YES;
        }
                            failure:^(NSError *error, NSDictionary *message)
        {
            [self showError:error WithMessage:message];
            sender.enabled = YES;
        }];
    }
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message
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
    NSDate *createdDate = [NSDate fromISO8601:valueData[@"at"]];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", valueData[@"value"], _streamUnit[@"symbol"] ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"at: %@", dateString];
    return cell;
}

@end
