
#import <UIKit/UIKit.h>
#import "CBBDistributionClient.h"

@interface AddDeviceViewController : UIViewController

@property (nonatomic, strong) CBBDistributionClient *dataSourceClient;
@property (nonatomic, strong) NSString *distribution_id;

@property (weak, nonatomic) IBOutlet UITextField *tfSerial;


@end
