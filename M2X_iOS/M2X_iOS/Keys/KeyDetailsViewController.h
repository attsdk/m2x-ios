
#import <UIKit/UIKit.h>
#import "M2XKey.h"

@interface KeyDetailsViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblKey;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiresAt;
@property (weak, nonatomic) IBOutlet UILabel *lblPermissions;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiresAtLabel;

@property (nonatomic, strong) M2XKey *key;

@end
