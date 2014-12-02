
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
    [_key viewWithCompletionHandler:^(M2XResource *resource, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            NSString *name = resource[@"name"];
            NSString *key = resource[@"key"];
            NSString *expiresAt = resource[@"expires_at"];
            
            NSString *permissions = [resource[@"permissions"] componentsJoinedByString:@", "];
            
            [_lblName setText:name];
            [_lblKey setText:key];
            [_lblPermissions setText:permissions];
            //check if expires_at isn't set.
            if(![expiresAt isEqual:[NSNull null]]){
                [_lblExpiresAtLabel setHidden:NO];
                [_lblExpiresAt setText:expiresAt];
            }
        }
    }];
}

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - btn

- (IBAction)regenerateKey:(id)sender {
    [_key regenerateWithCompletionHandler:^(M2XKey *key, M2XResponse *response) {
        if (response.error) {
            [self showError:response.errorObject withMessage:response.errorObject.userInfo];
        } else {
            _key = key;
            [_lblKey setText:_key[@"key"]];
        }
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
        [_key deleteWithCompletionHandler:^(M2XResponse *response) {
            if (response.error) {
                [self showError:response.errorObject withMessage:response.errorObject.userInfo];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
