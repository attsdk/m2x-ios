
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
    M2XClient *client = [[M2XClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiBaseUrl = [defaults objectForKey:@"api_base"];
    
    [client distributionsWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetDistributions:objects];
        }
    }];
}

-(void)didGetDistributions:(NSArray*)distributions
{
    _distributions = [distributions mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.distributions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    M2XDistribution *dist = [_distributions objectAtIndex:indexPath.row];
    cell.textLabel.text = dist[@"name"];
    NSString *description = dist[@"description"];
    
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
    UITableViewCell *key_tableViewSelected = sender;
    
    NSIndexPath *keyIndexPath = [[self tableView] indexPathForCell:key_tableViewSelected];
    
    M2XDistribution *dist = [_distributions objectAtIndex:[keyIndexPath row]];

    if ([segue.identifier isEqualToString:@"createDistribution"])
    {
        CreateDistributionViewController *createDistributionVC = segue.destinationViewController;
        createDistributionVC.client = dist.client;
    } else
    {
        DistributionDetailsViewController *batchDetailsVC = segue.destinationViewController;
        batchDetailsVC.distribution = dist;
        batchDetailsVC.title = dist[@"name"];
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
