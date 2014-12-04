
#import "DevicesListViewController.h"
#import "DeviceDescriptionViewController.h"

@interface DevicesListViewController ()

@end

@implementation DevicesListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    M2XClient *client = [[M2XClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiBaseUrl = [defaults objectForKey:@"api_base"];

    [client devicesWithParameters:nil completionHandler:^(NSArray *objects, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDeviceList:objects];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helpers methods

-(void)setMasterKey:(NSString *)masterkey andDeviceKey:(NSString *)deviceKey{
    _masterKey =  masterkey;
    _deviceKey = deviceKey;
}

-(void)didGetDeviceList:(NSArray *)devices
{
    _data = [NSMutableArray array];
    
    for (M2XDevice *device in devices) {
        //show only active devices
        if([device[@"status"] isEqualToString:@"enabled"])
            [_data addObject:device];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    M2XDevice *device = [_data objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:device[@"name"]];
    
    NSString *description = device[@"description"];

    //check if the description is not null
    if([description isEqual:[NSNull null]])
        [[cell detailTextLabel] setText:@""];
    else
        [[cell detailTextLabel] setText:description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return;
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        
    DeviceDescriptionViewController *deviceDetailsVC = segue.destinationViewController;
    
    UITableViewCell *device_tableViewSelected = sender;
    
    NSIndexPath *deviceIndexPath = [[self tableView] indexPathForCell:device_tableViewSelected];
    
    M2XDevice *device = [_data objectAtIndex:deviceIndexPath.row];
    
    deviceDetailsVC.device = device;
    
    deviceDetailsVC.title = device[@"name"];
    
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
