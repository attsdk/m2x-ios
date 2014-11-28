
#import <UIKit/UIKit.h>
#import "CBBKeysClient.h"

@interface KeyDetailsViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblKey;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiresAt;
@property (weak, nonatomic) IBOutlet UILabel *lblPermissions;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiresAtLabel;

@property (nonatomic, strong) CBBKeysClient *keysClient;
@property (nonatomic, strong) NSString *key;

@end
