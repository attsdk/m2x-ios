
#import <UIKit/UIKit.h>
#import "CBBDataSourceClient.h"

@interface AddDataSourceViewController : UIViewController

@property (nonatomic, strong) CBBDataSourceClient *dataSourceClient;
@property (nonatomic, strong) NSString *batch_id;

@property (weak, nonatomic) IBOutlet UITextField *tfSerial;


@end
