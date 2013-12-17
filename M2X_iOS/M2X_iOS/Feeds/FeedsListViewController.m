
#import "FeedsListViewController.h"
#import "M2x.h"
#import "FeedDescriptionViewController.h"

@interface FeedsListViewController ()

@end

@implementation FeedsListViewController

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
    
    _feedClient = [[FeedsClient alloc] init];
    
    //get list of feeds without parameters
    [_feedClient listWithParameters:nil success:^(id object) {
        //success callback
        [self didGetFeedList:object];
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
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

-(void)setMasterKey:(NSString *)masterkey andFeedKey:(NSString *)feedKey{
    _masterKey =  masterkey;
    _feedKey = feedKey;
}

-(void)didGetFeedList: (id) value
{
    NSDictionary *response = [value objectForKey:@"feeds"];
    
    _data = [NSMutableArray array];
    
    for (id feed in response) {
        [_data addObject:feed];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *feedData = [_data objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[feedData valueForKey:@"name"]];
    
    NSString *description = [feedData valueForKey:@"description"];

    //check the value in not null
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
        
    FeedDescriptionViewController *feedDetailsVC = segue.destinationViewController;
    
    UITableViewCell *feed_tableViewSelected = sender;
    
    NSIndexPath *feedIndexPath = [[self tableView] indexPathForCell:feed_tableViewSelected];
    
    NSDictionary *feedDict = [_data objectAtIndex:[feedIndexPath row]];
    
    feedDetailsVC.feed_id = [feedDict valueForKey:@"id"];
    
    feedDetailsVC.feedClient = _feedClient;
    
    feedDetailsVC.title = [feedDict valueForKey:@"name"];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
