
#import "DeviceDescriptionViewController.h"
#import "StreamValuesViewController.h"
#import "DeviceLocationViewController.h"
#import "AddStreamViewController.h"
#import "NSDate+M2X.h"
#import "CBBStreamClient.h"

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiUrl = [defaults objectForKey:@"api_base"];

    CBBStreamClient *streamClient = [[CBBStreamClient alloc] initWithClient:client];
    [streamClient listDataStreamsForDeviceId:_device_id completionHandler:^(CBBResponse *response) {
        [_streamList removeAllObjects];
        
        [_streamList addObjectsFromArray:[response.json objectForKey:@"streams"]];
        
        [_tableViewStreams reloadData];
    }];
    
}

-(void)getDeviceDescription{

    [_deviceClient viewDetailsForDeviceId:_device_id completionHandler:^(CBBResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDeviceDescription:response.json];
        }
    }];
    
}

- (void)didGetDeviceDescription:(NSDictionary*)device_description{
    
    [_lblDeviceId setText:[device_description valueForKey:@"id"]];
    
    //format date
    NSDate *createdDate = [NSDate fromISO8601:[device_description valueForKey:@"created"]];
    
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
    
    NSDictionary *deviceData = [_streamList objectAtIndex:indexPath.row];
    
    NSDictionary *valueUnitDic = [deviceData objectForKey:@"unit"];
    
    [[cell textLabel] setText:[deviceData valueForKey:@"name"]];
    
    NSString *value = [deviceData valueForKey:@"value"];
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiUrl = [defaults objectForKey:@"api_base"];

    CBBStreamClient *streamClient = [[CBBStreamClient alloc] initWithClient:client];
    if ([segue.identifier isEqualToString:@"toStreamValuesSegue"])
    {
        UITableViewCell *stream_tableViewSelected = sender;
        NSIndexPath *valueIndex = [self.tableViewStreams indexPathForCell:stream_tableViewSelected];
        NSDictionary *streamDict = self.streamList[valueIndex.row];
        StreamValuesViewController *StreamValuesVC = segue.destinationViewController;
        StreamValuesVC.deviceClient = streamClient;
        StreamValuesVC.device_id = _device_id;
        StreamValuesVC.streamName = streamDict[@"name"];
        StreamValuesVC.streamUnit = streamDict[@"unit"];
        StreamValuesVC.title = streamDict[@"name"];
        
    } else if([segue.identifier isEqualToString:@"toAddStream"]) {
        
        AddStreamViewController *addStreamVC = segue.destinationViewController;
        addStreamVC.deviceClient = streamClient;
        addStreamVC.device_id = _device_id;
        
    } else if([segue.identifier isEqualToString:@"toLocationsManagerSegue"]) {
        
        DeviceLocationViewController *locationVC = segue.destinationViewController;
        locationVC.deviceClient = _deviceClient;
        locationVC.device_id = _device_id;
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
