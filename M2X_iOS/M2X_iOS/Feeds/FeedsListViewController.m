
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
        
        NSLog(@"%@",[error description]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@", message]
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
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
    [[cell detailTextLabel] setText:[feedData valueForKey:@"description"]];
    
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
