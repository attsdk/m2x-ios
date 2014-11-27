
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
    
    [_dataSourceClient viewDetailsForDistributionId:_distribution_id completionHandler:^(CBBResponse *response) {
        if (response.error) {
            [self showError:response.error withMessage:response.error.userInfo];
        } else {
            [self didGetDistributionDescription:response.json];
        }
    }];
    
}

-(void)didGetDistributionDescription:(NSDictionary*)distribution{
    
    [_lblDistributionID setText:distribution[@"id"]];
    
    //format date
    NSDate *createdDate = [NSDate fromISO8601:distribution[@"created"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [_lblCreatedAt setText:dateString];
    
}

-(void)getDevicesForDistribution{
    
    [_dataSourceClient listDevicesFromDistribution:_distribution_id completionHandler:^(CBBResponse *response) {
        if (response.error) {
            [self showError:response.error withMessage:response.error.userInfo];
        } else {
            [self didGetDevicesForDistribution:response.json];
        }
    }];
    
}

-(void)didGetDevicesForDistribution:(NSDictionary*)dataSourcesList{
    
    [_dataSources removeAllObjects];
    
    [_dataSources addObjectsFromArray:[dataSourcesList objectForKey:@"devices"]];
    
    [_tableViewDataSources reloadData];
    
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    AddDeviceViewController *addDataSourceVC = segue.destinationViewController;
    
    addDataSourceVC.distribution_id = _distribution_id;
    
    addDataSourceVC.dataSourceClient = _dataSourceClient;
    
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
    
    NSDictionary *dataSourceData = [_dataSources objectAtIndex:indexPath.row];
    
    UIImage *status_img;
    
    if([[dataSourceData valueForKey:@"status"]isEqualToString:@"enabled"])
        status_img = [UIImage imageNamed:@"green.png"];
    else
        status_img = [UIImage imageNamed:@"red.png"];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:status_img];
    
    [[cell textLabel] setText:[dataSourceData valueForKey:@"name"]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"serial: %@",[dataSourceData valueForKey:@"serial"]]];
    
    return cell;
}

@end
