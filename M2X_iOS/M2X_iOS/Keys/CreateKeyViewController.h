
#import <UIKit/UIKit.h>
#import "KeysClient.h"

@interface CreateKeyViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) KeysClient *keysClient;

@property (weak, nonatomic) IBOutlet UISwitch *swGet;
@property (weak, nonatomic) IBOutlet UISwitch *swPost;
@property (weak, nonatomic) IBOutlet UISwitch *swPut;
@property (weak, nonatomic) IBOutlet UISwitch *swDelete;
@property (weak, nonatomic) IBOutlet UISwitch *swExpiryDate;
@property (weak, nonatomic) IBOutlet UITextField *tfMasterKeyLabel;
@property (weak, nonatomic) IBOutlet UITextField *tfExpiryDate;

@end
