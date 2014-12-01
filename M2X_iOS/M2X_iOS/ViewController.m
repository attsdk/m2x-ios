
#import "ViewController.h"
#import "DevicesListViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *tfMasterKey;
@property (strong, nonatomic) IBOutlet UITextField *tfURL;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.tfMasterKey.text = [defaults stringForKey:@"api_key"];
    self.tfMasterKey.delegate = self;

    self.tfURL.text = [defaults stringForKey:@"api_base"];
    self.tfURL.delegate = self;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_tfMasterKey text] forKey:@"api_key"];
    
    NSString *url = [_tfURL text].length > 0 ? [_tfURL text] : [_tfURL placeholder];
    [defaults setObject:url forKey:@"api_base"];
    [defaults synchronize];
}

- (IBAction)doSave:(id)sender
{
    if (self.tfMasterKey.text.length > 0)
    {
        [self performSegueWithIdentifier:@"ToContent" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Missing key"
                                    message:@"Please enter your AT&T M2X Master Key"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }
}

#pragma mark - UITextField 

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
