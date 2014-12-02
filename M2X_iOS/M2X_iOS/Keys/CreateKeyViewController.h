
#import <UIKit/UIKit.h>
#import "M2XClient.h"

@interface CreateKeyViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) M2XClient *client;

@property (weak, nonatomic) IBOutlet UISwitch *swGet;
@property (weak, nonatomic) IBOutlet UISwitch *swPost;
@property (weak, nonatomic) IBOutlet UISwitch *swPut;
@property (weak, nonatomic) IBOutlet UISwitch *swDelete;
@property (weak, nonatomic) IBOutlet UISwitch *swExpiryDate;
@property (weak, nonatomic) IBOutlet UITextField *tfMasterKeyLabel;
@property (weak, nonatomic) IBOutlet UITextField *tfExpiryDate;

@end
