
#import <UIKit/UIKit.h>
#import "CBBDistributionClient.h"

@interface CreateDistributionViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *smtVisibility;
@property (nonatomic, strong) CBBDistributionClient *dataSourceClient;

@end
