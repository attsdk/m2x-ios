
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tfMasterKey;

@property (strong, nonatomic) IBOutlet UITextField *tfFeedKey;

@property (strong, nonatomic) IBOutlet UITextField *tfURL;

@end
