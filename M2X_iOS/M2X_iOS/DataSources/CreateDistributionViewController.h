
#import <UIKit/UIKit.h>

@interface CreateDistributionViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *smtVisibility;
@property (nonatomic, strong) M2XClient *client;

@end
