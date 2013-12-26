
#import "FeedDescriptionViewController.h"
#import "StreamValuesViewController.h"
#import "FeedLocationViewController.h"
#import "AddStreamViewController.h"

@interface FeedDescriptionViewController ()

@end

@implementation FeedDescriptionViewController

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
    
    [self getFeedDescription];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - support

-(void)getFeedDescription{

    [_feedClient viewDetailsForFeedId:_feed_id success:^(id object) {
        
        NSLog(@"%@",object);
        [self didGetFeedDescription:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
    
}

- (void)didGetFeedDescription:(NSDictionary*)feed_description{
    
    [_lblFeedId setText:[feed_description valueForKey:@"id"]];
    
    //format date
    NSDate *createdDate = [[M2x shared] iSO8601ToDate:[feed_description valueForKey:@"created"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [_lblCreated setText:dateString];
    
    [_streamList removeAllObjects];
    
    [_streamList addObjectsFromArray:[feed_description objectForKey:@"streams"]];
    
    [_tableViewStreams reloadData];
    
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
    
    NSDictionary *feedData = [_streamList objectAtIndex:indexPath.row];
    
    NSDictionary *valueUnitDic = [feedData objectForKey:@"unit"];
    
    [[cell textLabel] setText:[feedData valueForKey:@"name"]];
    
    NSString *value = [feedData valueForKey:@"value"];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"toStreamValuesSegue"])
    {
        UITableViewCell *stream_tableViewSelected = sender;
        
        NSIndexPath *valueIndex = [_tableViewStreams indexPathForCell:stream_tableViewSelected];
        
        NSDictionary *streamDict = [_streamList objectAtIndex:[valueIndex row]];
        
        StreamValuesViewController *streamValuesVC = segue.destinationViewController;
        
        [streamValuesVC setFeedClient:_feedClient];
        
        [streamValuesVC setFeed_id:_feed_id];
        
        [streamValuesVC setStreamName:[streamDict valueForKey:@"name"]];
        
        [streamValuesVC setStreamUnit:[streamDict objectForKey:@"unit"]];
        
        [streamValuesVC setTitle:[streamDict valueForKey:@"name"]];
        
    }else if([[segue identifier] isEqualToString:@"toAddStream"]) {
        
        AddStreamViewController *addStreaVC = segue.destinationViewController;
        
        [addStreaVC setFeedClient:_feedClient];
        
        [addStreaVC setFeed_id:_feed_id];
        
    }else{ // segue is "toLocationsManagerSegue"
        
        FeedLocationViewController *locationVC = segue.destinationViewController;
        
        [locationVC setFeed_id:_feed_id];
        
        [locationVC setFeedClient:_feedClient];
        
    }
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end
