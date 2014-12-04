
#import <UIKit/UIKit.h>

@interface AddStreamViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) M2XDevice *device;
@property (weak, nonatomic) IBOutlet UITextField *tfStreamId;
@property (weak, nonatomic) IBOutlet UITextField *tfUnit;
@property (weak, nonatomic) IBOutlet UITextField *tfSymbol;
@property (weak, nonatomic) IBOutlet UITextField *tfLogAValue;
@property (weak, nonatomic) IBOutlet UITextField *activeTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewAddStream;
@property (nonatomic) CGFloat animatedDistance;

@end
