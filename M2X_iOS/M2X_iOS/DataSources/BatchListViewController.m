
#import "BatchListViewController.h"
#import "BatchDetailsViewController.h"

@interface BatchListViewController ()

@end

@implementation BatchListViewController

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
    
    [super viewDidLoad];
    
    _dataSourceClient = [[DataSourceClient alloc] init];
    
    //get list of feeds without parameters
    [_dataSourceClient listBatchWithSuccess:^(id object) {
        //success callback
        [self didGetBatches:object];
    } failure:^(NSError *error, NSDictionary *message) {
        
        NSLog(@"%@",[error description]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@", message]
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

-(void)didGetBatches:(NSDictionary*)batches{
    
    NSDictionary *response = [batches objectForKey:@"batches"];
    
    _data = [NSMutableArray array];
    
    for (id batch in response) {
        [_data addObject:batch];
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
    
    BatchDetailsViewController *batchDetailsVC = segue.destinationViewController;
    
    UITableViewCell *batch_tableViewSelected = sender;
    
    NSIndexPath *batchIndexPath = [[self tableView] indexPathForCell:batch_tableViewSelected];
    
    NSDictionary *batchDict = [_data objectAtIndex:[batchIndexPath row]];
    
    batchDetailsVC.batch_id = [batchDict valueForKey:@"id"];
    
    batchDetailsVC.dataSourceClient = _dataSourceClient;
    
    batchDetailsVC.title = [batchDict valueForKey:@"name"];
    
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
