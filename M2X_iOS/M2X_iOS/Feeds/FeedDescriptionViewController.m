
#import "FeedDescriptionViewController.h"
#import "StreamValuesViewController.h"
#import "FeedLocationViewController.h"
#import "AddStreamViewController.h"
#import "NSDate+M2X.h"

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
        
        [self didGetFeedDescription:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
    
}

- (void)didGetFeedDescription:(NSDictionary*)feed_description{
    
    [_lblFeedId setText:[feed_description valueForKey:@"id"]];
    
    //format date
    NSDate *createdDate = [NSDate fromISO8601:[feed_description valueForKey:@"created"]];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toStreamValuesSegue"])
    {
        UITableViewCell *stream_tableViewSelected = sender;
        NSIndexPath *valueIndex = [self.tableViewStreams indexPathForCell:stream_tableViewSelected];
        NSDictionary *streamDict = self.streamList[valueIndex.row];
        StreamValuesViewController *streamValuesVC = segue.destinationViewController;
        streamValuesVC.feedClient = self.feedClient;
        streamValuesVC.feed_id = _feed_id;
        streamValuesVC.streamName = streamDict[@"name"];
        streamValuesVC.streamUnit = streamDict[@"unit"];
        streamValuesVC.title = streamDict[@"name"];
        
    } else if([segue.identifier isEqualToString:@"toAddStream"]) {
        
        AddStreamViewController *addStreamVC = segue.destinationViewController;
        addStreamVC.feedClient = self.feedClient;
        addStreamVC.feed_id = _feed_id;
        
    } else if([segue.identifier isEqualToString:@"toLocationsManagerSegue"]) {
        
        FeedLocationViewController *locationVC = segue.destinationViewController;
        locationVC.feedClient = _feedClient;
        locationVC.feed_id = _feed_id;
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
