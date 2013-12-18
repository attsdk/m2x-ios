
#import "BatchListViewController.h"
#import "BatchDetailsViewController.h"
#import "CreateBatchViewController.h"

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
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    //get list of feeds without parameters
    [_dataSourceClient listBatchWithSuccess:^(id object) {
        //success callback
        [self didGetBatches:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
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
    
    NSDictionary *batchData = [_data objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[batchData valueForKey:@"name"]];
    
    NSString *description = [batchData valueForKey:@"description"];
    
    //check if the description is not null
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
    
    if([[segue identifier] isEqualToString:@"createBatch"]){
    
        CreateBatchViewController *createBatchVC = segue.destinationViewController;
        
        createBatchVC.dataSourceClient = _dataSourceClient;
    
    }else{
        
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

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
