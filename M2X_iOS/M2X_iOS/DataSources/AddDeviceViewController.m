
#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addDeviceBtnPushed:(id)sender {
    
    if([[_tfSerial text] isEqualToString:@""]){
        return;
    }
    
    //Create the Dictionary
    NSDictionary *serial = @{ @"serial": [_tfSerial text] };
    
    //Add Device to the Distribution
    __weak typeof(self) weakSelf = self;
    
    [_dataSourceClient addDeviceToDistribution:_distribution_id
                             withParameters:serial
                                    completionHandler:^(CBBResponse *response) {
                                        
                                        if (response.error) {
                                            [weakSelf showError:response.error withMessage:response.error.userInfo];
                                        } else {
                                            [weakSelf.navigationController popViewControllerAnimated:YES];
                                        }
                                    }];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error withMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
