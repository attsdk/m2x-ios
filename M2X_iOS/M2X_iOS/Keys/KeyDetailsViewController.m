
#import "KeyDetailsViewController.h"

@interface KeyDetailsViewController ()

@end

@implementation KeyDetailsViewController

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
    
    [self getKeyDetails];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

- (void)getKeyDetails{
    
    [_keysClient viewDetailsForKey:_key success:^(id object) {
        
        NSString *name = [object valueForKey:@"name"];
        NSString *key = [object valueForKey:@"key"];
        NSString *expiresAt = [object valueForKey:@"expires_at"];
        
        NSString *permissions = [[object objectForKey:@"permissions"] componentsJoinedByString:@", "];

        [_lblName setText:name];
        [_lblKey setText:key];
        [_lblPermissions setText:permissions];
        if(![expiresAt isEqual:[NSNull null]]){
            [_lblExpiresAtLabel setHidden:NO];
            [_lblExpiresAt setText:expiresAt];
        }
        
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
    
}

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - btn

- (IBAction)regenerateKey:(id)sender {
    [_keysClient regenerateKey:_key success:^(id object) {
        
        //Update key label
        [_lblKey setText:[object valueForKey:@"key"]];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
}

- (IBAction)deleteKey:(id)sender {
    //show delete alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Warning"
                                                    message: @"Are you sure you want to delete this key?"
                                                   delegate: self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Delete", nil];
    [alert show];
}

// UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_keysClient deleteKey:_key success:^(id object) {
            
            //key deleted.
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error, NSDictionary *message) {
            
            [self showError:error WithMessage:message];
            
        }];
    }
}

@end
