
#import "ViewController.h"
#import "FeedsListViewController.h"
#import "FeedsClient.h"
#import "M2x.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [_tfMasterKey setText:[defaults stringForKey:@"api_key"]];

    [_tfURL setText:[defaults stringForKey:@"api_url"]];
    
    
    [_tfMasterKey setDelegate:self];
    [_tfURL setDelegate:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[_tfMasterKey text] forKey:@"api_key"];
    
    [defaults setObject:[_tfURL text] forKey:@"api_url"];
    
    [defaults synchronize];
    
    
    M2x* m2x = [M2x shared];
    //set the Master Api Key
    m2x.api_key = [_tfMasterKey text];
    //set the api url
    m2x.api_url = [_tfURL text];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField 

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
