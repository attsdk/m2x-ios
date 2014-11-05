
#import <UIKit/UIKit.h>
#import "CBBFeedsClient.h"

@interface AddStreamViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString *feed_id;
@property (strong, nonatomic) CBBFeedsClient *feedClient;
@property (weak, nonatomic) IBOutlet UITextField *tfStreamId;
@property (weak, nonatomic) IBOutlet UITextField *tfUnit;
@property (weak, nonatomic) IBOutlet UITextField *tfSymbol;
@property (weak, nonatomic) IBOutlet UITextField *tfLogAValue;
@property (weak, nonatomic) IBOutlet UITextField *activeTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewAddStream;
@property (nonatomic) CGFloat animatedDistance;

@end
