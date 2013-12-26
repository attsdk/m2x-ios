
#import "CreateKeyViewController.h"
#import "DatePickerViewController.h"

@interface CreateKeyViewController ()

@end

@implementation CreateKeyViewController

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
	
    [_tfMasterKeyLabel setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMasterkey:(id)sender {
    
    //Master Key label is required
    if([[_tfMasterKeyLabel text] isEqualToString:@""])
        return;
    
    //Set the permissions:
    NSMutableArray *permissions = [NSMutableArray array];
    
    if([_swGet isOn]) [permissions addObject:@"GET"];
    
    if([_swPost isOn]) [permissions addObject:@"POST"];

    if([_swPut isOn]) [permissions addObject:@"PUT"];

    if([_swDelete isOn]) [permissions addObject:@"DELETE"];
    
    //create key object
    NSMutableDictionary *key = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[_tfMasterKeyLabel text],permissions,[NSNull null],[NSNull null],nil]
                                                                  forKeys:[NSArray arrayWithObjects:@"name",@"permissions",@"feed",@"stream",nil]];
    
    //Set the expiry date:
    if([_swExpiryDate isOn] && ![[_tfExpiryDate text] isEqualToString:@""])
        [key setValue:[_tfExpiryDate text] forKey:@"expires_at"];
    
    [_keysClient createKey:key success:^(id object) {
        
        //batch successfully created.
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
    
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    DatePickerViewController *datePickerVC = segue.destinationViewController;
    
    datePickerVC.tfExpiryDate = _tfExpiryDate;
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //segue only if the expiry switch is on.
    return [_swExpiryDate isOn];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}




@end
