
#import "CreateBatchViewController.h"

@interface CreateBatchViewController ()

@end

@implementation CreateBatchViewController

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

- (IBAction)createBatch:(id)sender {
    
    if([[_tfName text] isEqualToString:@""]){
        return;
    }
    
    NSDictionary *batch = @{ @"name": [_tfName text] ,
                             @"description": [_tfDescription text],
                             @"visibility": [_smtVisibility titleForSegmentAtIndex:[_smtVisibility selectedSegmentIndex]]};
    
    [_dataSourceClient createBatch:batch success:^(id object) {
        
        //batch successfully created.
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
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
