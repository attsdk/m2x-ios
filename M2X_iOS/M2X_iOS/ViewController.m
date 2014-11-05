
#import "ViewController.h"
#import "FeedsListViewController.h"
#import "FeedsClient.h"
#import "M2x.h"

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

    self.tfURL.text = [[defaults stringForKey:@"api_url"] length] > 0 ? [defaults stringForKey:@"api_url"] : [[M2x shared] apiUrl];
    self.tfURL.delegate = self;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_tfMasterKey text] forKey:@"api_key"];
    [defaults setObject:[_tfURL text] forKey:@"api_url"];
    [defaults synchronize];
    
    
    M2x* m2x = [M2x shared];
    m2x.apiKey = [_tfMasterKey text]; // Master API Key
    m2x.apiUrl = [_tfURL text]; // M2X API endpoint URL
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
