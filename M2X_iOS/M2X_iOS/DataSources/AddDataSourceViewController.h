
#import <UIKit/UIKit.h>
#import "DataSourceClient.h"

@interface AddDataSourceViewController : UIViewController

@property (nonatomic, strong) DataSourceClient *dataSourceClient;
@property (nonatomic, strong) NSString *batch_id;

@property (weak, nonatomic) IBOutlet UITextField *tfSerial;


@end
