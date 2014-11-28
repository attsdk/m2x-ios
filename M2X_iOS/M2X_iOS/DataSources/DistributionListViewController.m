
#import "DistributionListViewController.h"
#import "DistributionDetailsViewController.h"
#import "CreateDistributionViewController.h"

@interface DistributionListViewController ()

@end

@implementation DistributionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiUrl = [defaults objectForKey:@"api_base"];
    self.dataSourceClient = [[CBBDistributionClient alloc] initWithClient:client];
}

- (void)viewDidAppear:(BOOL)animated
{
    //get list of devices without parameters
    [_dataSourceClient listDistributionsWithCompletionHandler:^(CBBResponse *response)
    {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDistributions:response.json];
        }

    }];
}

-(void)didGetDistributions:(NSDictionary*)distributions
{
    _data = [NSMutableArray array];
    [_data addObjectsFromArray:[distributions objectForKey:@"distributions"]];
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
    
    if ([segue.identifier isEqualToString:@"createDistribution"])
    {
        CreateDistributionViewController *createDistributionVC = segue.destinationViewController;
        createDistributionVC.dataSourceClient = _dataSourceClient;
    } else
    {
        DistributionDetailsViewController *batchDetailsVC = segue.destinationViewController;
        UITableViewCell *batch_tableViewSelected = sender;
        NSIndexPath *batchIndexPath = [[self tableView] indexPathForCell:batch_tableViewSelected];
        NSDictionary *batchDict = [_data objectAtIndex:[batchIndexPath row]];
        batchDetailsVC.distribution_id = [batchDict valueForKey:@"id"];
        batchDetailsVC.dataSourceClient = _dataSourceClient;
        batchDetailsVC.title = [batchDict valueForKey:@"name"];
    }
    
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
