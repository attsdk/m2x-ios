
#import <UIKit/UIKit.h>
#import "CBBDistributionClient.h"

@interface AddDeviceViewController : UIViewController

@property (nonatomic, strong) M2XDistribution *distribution;

@property (weak, nonatomic) IBOutlet UITextField *tfSerial;


@end
