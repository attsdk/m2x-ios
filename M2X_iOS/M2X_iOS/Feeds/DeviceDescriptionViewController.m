
#import "DeviceDescriptionViewController.h"
#import "StreamValuesViewController.h"
#import "DeviceLocationViewController.h"
#import "AddStreamViewController.h"
#import "NSDate+M2X.h"

@interface DeviceDescriptionViewController ()

@end

@implementation DeviceDescriptionViewController

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
    
    _streamList = [NSMutableArray array];
    
    _tableViewStreams.dataSource = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getDeviceDescription];
    
    [self getDeviceStreams];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - support

-(void)getDeviceStreams {
    [_device streamsWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        [_streamList removeAllObjects];
        
        [_streamList addObjectsFromArray:objects];
        
        [_tableViewStreams reloadData];
    }];
}

-(void)getDeviceDescription{
    [_device viewWithCompletionHandler:^(M2XResource *device, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDeviceDescription:(M2XDevice *)device];
        }
    }];
}

- (void)didGetDeviceDescription:(M2XDevice*)device{
    
    [_lblDeviceId setText:device[@"id"]];
    
    //format date
    NSDate *createdDate = [NSDate fromISO8601:device[@"created"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [_lblCreated setText:dateString];
}


-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

#pragma mark - TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Streams";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_streamList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    M2XStream *stream = [_streamList objectAtIndex:indexPath.row];
    
    NSDictionary *valueUnitDic = stream[@"unit"];
    
    [[cell textLabel] setText:stream[@"name"]];
    
    NSString *value = stream[@"value"];
    
    if([value  isEqual: [NSNull null]]){
        [[cell detailTextLabel] setText:@"No Stream Data Available."];
    }else{
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"value: %@ %@",value,
                                         ([[valueUnitDic valueForKey:@"symbol"] isEqual:[NSNull null]]) ? @"" : [valueUnitDic valueForKey:@"symbol"]
                                         ]];
    }
    
    
    return cell;
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *stream_tableViewSelected = sender;
    NSIndexPath *valueIndex = [self.tableViewStreams indexPathForCell:stream_tableViewSelected];
    M2XStream *stream = self.streamList[valueIndex.row];
    if ([segue.identifier isEqualToString:@"toStreamValuesSegue"])
    {
        StreamValuesViewController *StreamValuesVC = segue.destinationViewController;
        StreamValuesVC.stream = stream;
        StreamValuesVC.streamName = stream[@"name"];
        StreamValuesVC.streamUnit = stream[@"unit"];
        StreamValuesVC.title = stream[@"name"];
        
    } else if([segue.identifier isEqualToString:@"toAddStream"]) {
        AddStreamViewController *addStreamVC = segue.destinationViewController;
        addStreamVC.device = _device;
        
    } else if([segue.identifier isEqualToString:@"toLocationsManagerSegue"]) {

        DeviceLocationViewController *locationVC = segue.destinationViewController;
        locationVC.device = _device;
    }
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end
