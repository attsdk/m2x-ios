
#import "BatchListViewController.h"
#import "BatchDetailsViewController.h"
#import "CreateBatchViewController.h"

@interface BatchListViewController ()

@end

@implementation BatchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceClient = [CBBDataSourceClient new];
}

- (void)viewDidAppear:(BOOL)animated
{
    //get list of feeds without parameters
    [_dataSourceClient listBatchWithSuccess:^(id object)
    {
        //success callback
        [self didGetBatches:object];
    }
                                    failure:^(NSError *error, NSDictionary *message)
    {
        [self showError:error WithMessage:message];
    }];
}

-(void)didGetBatches:(NSDictionary*)batches
{
    _data = [NSMutableArray array];
    [_data addObjectsFromArray:[batches objectForKey:@"batches"]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    NSDictionary *batchData = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = [batchData valueForKey:@"name"];
    NSString *description = [batchData valueForKey:@"description"];
    
    //check if the description is not null
    if([description isEqual:[NSNull null]]) {
        cell.detailTextLabel.text = @"";
    } else {
        cell.detailTextLabel.text = description;
    }
    
    return cell;
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"createBatch"])
    {
        CreateBatchViewController *createBatchVC = segue.destinationViewController;
        createBatchVC.dataSourceClient = _dataSourceClient;
    } else
    {
        BatchDetailsViewController *batchDetailsVC = segue.destinationViewController;
        UITableViewCell *batch_tableViewSelected = sender;
        NSIndexPath *batchIndexPath = [[self tableView] indexPathForCell:batch_tableViewSelected];
        NSDictionary *batchDict = [_data objectAtIndex:[batchIndexPath row]];
        batchDetailsVC.batch_id = [batchDict valueForKey:@"id"];
        batchDetailsVC.dataSourceClient = _dataSourceClient;
        batchDetailsVC.title = [batchDict valueForKey:@"name"];
    }
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
