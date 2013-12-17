
#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (nonatomic, strong) UITextField *tfExpiryDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpExpiryDate;

@end
