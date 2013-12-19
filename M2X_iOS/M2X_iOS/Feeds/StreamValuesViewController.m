
#import "StreamValuesViewController.h"

@interface StreamValuesViewController ()

@end

@implementation StreamValuesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _valueList = [NSMutableArray array];
    
    _tableViewStreamValues.dataSource = self;
    
    [_lblUnit setText:[_streamUnit valueForKey:@"symbol"]];
    
    [self getStreamValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
#pragma mark - request

-(void)getStreamValues{
    
    //assign a limit of streams values
    NSDictionary *parameters = @{ @"limit": @"100" };
    
    [_feedClient listDataValuesFromTheStream:_streamName inFeed:_feed_id WithParameters:parameters success:^(id object) {
        NSLog(@"%@",object);
        [self didGetStreamValues:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        NSLog(@"%@",message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@", message]
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}

-(void)didGetStreamValues:(NSDictionary*)values{
    
    [_valueList removeAllObjects];
    
    [_valueList addObjectsFromArray:[values objectForKey:@"values"]];
    
    [_tableViewStreamValues reloadData];
    
}

#pragma mark - IBAction

- (IBAction)postValue:(id)sender {
    
    if(![[_tfNewValue text] isEqual: @""]){
        
        NSDictionary *newValue = @{ @"values": @[
                   @{ @"value": [_tfNewValue text] } ] };
        
        [_feedClient postDataValues:newValue forStream:_streamName inFeed:_feed_id success:^(id object) {
            [self getStreamValues];
        } failure:^(NSError *error, NSDictionary *message) {
            
            [self showError:error WithMessage:message];
            
        }];
        
    }
    
    [_tfNewValue resignFirstResponder];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
    return [_valueList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *valueData = [_valueList objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@",[valueData valueForKey:@"value"],[_streamUnit valueForKey:@"symbol"]]];
    
    NSDate *createdDate = [[M2x shared] iSO8601ToDate:[valueData valueForKey:@"at"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"at: %@",dateString]];
    
    return cell;
}

@end
