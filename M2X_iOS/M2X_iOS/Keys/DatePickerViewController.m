
#import "DatePickerViewController.h"
#import "M2x.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

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
- (IBAction)datePicked:(id)sender {
    
    NSDate *date = [_dpExpiryDate date];
    
    NSString *dateString = [[M2x shared] dateToISO8601:date];
    
    [_tfExpiryDate setText:dateString];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
