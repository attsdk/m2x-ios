
#import "StreamValuesViewController.h"
#import "NSDate+M2X.h"

@interface StreamValuesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfNewValue;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreamValues;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;

@property (nonatomic, retain) NSMutableArray *valueList;

@end

@implementation StreamValuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewStreamValues.dataSource = self;
    
    if (![self.streamUnit[@"symbol"] isEqual:[NSNull null]]) {
        self.lblUnit = self.streamUnit[@"symbol"];
    }
    
    [self getStreamValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
#pragma mark - request

-(void)getStreamValues
{
    NSLog(@"Downloading stream values.");
    NSDictionary *parameters = @{ @"limit": @"100" };
    [_feedClient listDataValuesFromTheStream:_streamName
                                      inFeed:_feed_id
                              WithParameters:parameters
                                     success:^(NSDictionary *object)
    {
        self.valueList = object[@"values"];
        [self.tableViewStreamValues reloadData];
        NSLog(@"%d stream values displayed.", self.valueList.count);
    }
                                     failure:^(NSError *error, NSDictionary *message)
    {
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
        sender.enabled = NO;
        [_tfNewValue resignFirstResponder];
        
        NSDictionary *value = @{ @"values": @[
                   @{ @"value": _tfNewValue.text, @"at": [[NSDate date] toISO8601] }
                   ] };
        
        [_feedClient postDataValues:value
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
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@",[valueData valueForKey:@"value"],
                               ([[_streamUnit valueForKey:@"symbol"] isEqual:[NSNull null]]) ? @"" : [_streamUnit valueForKey:@"symbol"]
                               ]];
    
    NSDate *createdDate = [NSDate fromISO8601:[valueData valueForKey:@"at"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"at: %@",dateString]];
    
    return cell;
}

@end
