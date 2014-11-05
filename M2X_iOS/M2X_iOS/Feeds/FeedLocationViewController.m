
#import "FeedLocationViewController.h"
#import "CBBFeedsClient.h"
#import "NSDate+M2X.h"

@interface FeedLocationViewController ()

@end

@implementation FeedLocationViewController




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
    //table data source
    _tableViewLocations.dataSource = self;
    _locationsList = [NSMutableArray array];
	
    //init locationManager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    [self getFeedLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFeedLocations{
    
    [_feedClient readDataLocationInFeed:_feed_id completionHandler:^(id object, NSURLResponse *response, NSError *error) {
        if (error) {
            [self showError:error WithMessage:error.userInfo];
        } else {
            [self didGetFeedLocation:object];
        }
    }];
    
}

- (void)didGetFeedLocation:(NSDictionary*)feed_location{
    
    //Locations inputs
    [_tfLocationName setText:[feed_location valueForKey:@"name"]];
    [_tfLatitude setText:[feed_location valueForKey:@"latitude"]];
    [_tfLongitude setText:[feed_location valueForKey:@"longitude"]];
    [_tfElevation setText:[feed_location valueForKey:@"elevation"]];
    
    [_locationsList removeAllObjects];
    
    [_locationsList addObjectsFromArray:[feed_location objectForKey:@"waypoints"]];
    
    [_tableViewLocations reloadData];
    
}

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void)didGetTheLocality{
    
    CLLocation *location = [_locationManager location];
    
    NSDictionary *locationDict = @{ @"name": _currentLocality,
                                    @"latitude": [NSString stringWithFormat:@"%f",location.coordinate.latitude],
                                    @"longitude": [NSString stringWithFormat:@"%f",location.coordinate.longitude],
                                    @"elevation": [NSString stringWithFormat:@"%f",location.altitude]};
    
    [_feedClient updateDatasourceWithLocation:locationDict inFeed:_feed_id completionHandler:^(id object, NSURLResponse *response, NSError *error) {
        if (error) {
            [self showError:error WithMessage:error.userInfo];
        } else {
            [self getFeedLocations];
        }
    }];
    
}

- (IBAction)didBtnPressed:(id)sender {
    
    CLLocation *location = [_locationManager location];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    _currentLocality = @"";
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            _currentLocality = [placemark locality];
            [self didGetTheLocality];
        }
    }];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
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
    return @"Waypoints";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_locationsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *valueData = [_locationsList objectAtIndex:indexPath.row];
    
    cell.textLabel.font  = [ UIFont fontWithName: @"Arial" size: 14.0 ];;
    
    //formating floats
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingIncrement = [NSNumber numberWithDouble:0.01];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *latitude  = [NSNumber numberWithDouble:[[valueData valueForKey:@"latitude"] floatValue]];
    NSNumber *longitude  = [NSNumber numberWithDouble:[[valueData valueForKey:@"longitude"] floatValue]];
    NSNumber *elevation  = [NSNumber numberWithDouble:[[valueData valueForKey:@"elevation"] floatValue]];
    
    NSString *timeString = [valueData valueForKey:@"timestamp"];
    
    NSDate *timestamp = [NSDate fromISO8601:timeString];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"Lat:%@ | Long:%@ | E:%@",
                               [formatter stringFromNumber:latitude],
                               [formatter stringFromNumber:longitude],
                               [formatter stringFromNumber:elevation]]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:timestamp
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [[cell detailTextLabel] setText:dateString];
    
    return cell;
}

@end
