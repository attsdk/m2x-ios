
#import "KeyListViewController.h"
#import "CreateKeyViewController.h"
#import "KeyDetailsViewController.h"
#import "M2XClient.h"
#import "M2XKey.h"

@interface KeyListViewController ()

@end

@implementation KeyListViewController

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
    
    _keysArray = [NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    M2XClient *client = [[M2XClient alloc] initWithApiKey:[defaults objectForKey:@"api_key"]];
    client.apiBaseUrl = [defaults objectForKey:@"api_base"];
    
    [client keysWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            [self didGetKeysList:objects];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

- (void)didGetKeysList:(NSArray*)keysList{
    
    [_keysArray removeAllObjects];
    
    [_keysArray addObjectsFromArray:keysList];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_keysArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    M2XKey *key = [_keysArray objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:key[@"name"]];
    [[cell detailTextLabel] setText:key[@"key"]];
    
    return cell;
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell *key_tableViewSelected = sender;

    NSIndexPath *keyIndexPath = [[self tableView] indexPathForCell:key_tableViewSelected];
    
    M2XKey *key = [_keysArray objectAtIndex:[keyIndexPath row]];

    if ([[segue identifier] isEqualToString:@"goCreateKeyViewController"]){
        
        CreateKeyViewController *createKeyVC = segue.destinationViewController;
        
        createKeyVC.client = key.client;
        
    }else if ([[segue identifier] isEqualToString:@"goKeyDescription"]){
        
        KeyDetailsViewController *keyDescriptionVC = segue.destinationViewController;
        
        keyDescriptionVC.key = key;
    }
    
}

@end
