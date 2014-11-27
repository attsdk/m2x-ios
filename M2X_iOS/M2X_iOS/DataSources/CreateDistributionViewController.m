
#import "CreateDistributionViewController.h"

@interface CreateDistributionViewController ()

@end

@implementation CreateDistributionViewController

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
	
    [_tfDescription setDelegate:self];
    [_tfName setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBOutlet

- (IBAction)createDistribution:(id)sender {
    
    if([[_tfName text] isEqualToString:@""]){
        return;
    }
    
    NSDictionary *distribution = @{ @"name": [_tfName text] ,
                             @"description": [_tfDescription text],
                             @"visibility": [_smtVisibility titleForSegmentAtIndex:[_smtVisibility selectedSegmentIndex]]};
    
    [_dataSourceClient createDistribution:distribution completionHandler:^(CBBResponse *response) {
        if (response.error) {
            [self showError:response.error WithMessage:response.error.userInfo];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

//hide text fields
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


@end
