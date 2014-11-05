
#import "AddDataSourceViewController.h"

@interface AddDataSourceViewController ()

@end

@implementation AddDataSourceViewController

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
- (IBAction)addDataSourceBtnPushed:(id)sender {
    
    if([[_tfSerial text] isEqualToString:@""]){
        return;
    }
    
    //Create the Dictionary
    NSDictionary *serial = @{ @"serial": [_tfSerial text] };
    
    //Add Data Source to the Distribution
    __weak typeof(self) weakSelf = self;
    
    [_dataSourceClient addDataSourceToDistribution:_distribution_id
                             withParameters:serial
                                    success:^(id object) {
                                        
                                        //data source successfully added, go back.
                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                        
                                    } failure:^(NSError *error, NSDictionary *message) {
                                        
                                        [weakSelf showError:error WithMessage:message];
                                        
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

@end
