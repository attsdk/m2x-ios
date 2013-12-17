
#import "KeyListViewController.h"
#import "CreateKeyViewController.h"
#import "KeysClient.h"

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
    
    _keysClient = [[KeysClient alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [_keysClient listKeysWithParameters:nil success:^(id object) {
        
        [self didGetKeysList:object];
        
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

- (void)didGetKeysList:(NSDictionary*)keysList{
    
    NSDictionary *response = [keysList objectForKey:@"keys"];
    
    _keysArray = [NSMutableArray array];
    
    for (id batch in response) {
        [_keysArray addObject:batch];
    }
    
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
    
    NSDictionary *keyData = [_keysArray objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[keyData valueForKey:@"name"]];
    [[cell detailTextLabel] setText:[keyData valueForKey:@"key"]];
    
    return cell;
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    CreateKeyViewController *createKeyVC = segue.destinationViewController;
    
    createKeyVC.keysClient = _keysClient;
    
}

@end
