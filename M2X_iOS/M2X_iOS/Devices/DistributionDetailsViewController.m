
#import "DistributionDetailsViewController.h"
#import "AddDeviceViewController.h"
#import "NSDate+M2X.h"

@interface DistributionDetailsViewController ()

@end

@implementation DistributionDetailsViewController

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
	
    _dataSources = [NSMutableArray array];
    
    _tableViewDataSources.dataSource = self;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self getDistributionDescription];
    
    [self getDevicesForDistribution];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

-(void)getDistributionDescription{
    [_distribution viewWithCompletionHandler:^(M2XResource *resource, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDistributionDescription:(M2XDistribution *)resource];
        }
    }];
    
}

-(void)didGetDistributionDescription:(M2XDistribution*)distribution{
    
    [_lblDistributionID setText:distribution[@"id"]];
    
    //format date
    NSDate *createdDate = [NSDate fromISO8601:distribution[@"created"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [_lblCreatedAt setText:dateString];
    
}

-(void)getDevicesForDistribution{
    [_distribution devicesWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDevicesForDistribution:objects];
        }
    }];
    
}

-(void)didGetDevicesForDistribution:(NSArray*)dataSourcesList{
    
    [_dataSources removeAllObjects];
    
    [_dataSources addObjectsFromArray:dataSourcesList];
    
    [_tableViewDataSources reloadData];
    
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    AddDeviceViewController *addDataSourceVC = segue.destinationViewController;
    addDataSourceVC.distribution = _distribution;
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    M2XDevice *device = [_dataSources objectAtIndex:indexPath.row];
    
    UIImage *status_img;
    
    if([device[@"status"] isEqualToString:@"enabled"])
        status_img = [UIImage imageNamed:@"green.png"];
    else
        status_img = [UIImage imageNamed:@"red.png"];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:status_img];
    
    [[cell textLabel] setText:device[@"name"]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"serial: %@", device[@"serial"]]];
    
    return cell;
}

@end
