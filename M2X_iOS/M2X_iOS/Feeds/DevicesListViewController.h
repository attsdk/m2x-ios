
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CBBDeviceClient.h"

@interface DevicesListViewController : UITableViewController {
    
}
@property (strong, nonatomic) NSString *masterKey;
@property (strong, nonatomic) NSString *deviceKey;
@property (strong, nonatomic) CBBDeviceClient *deviceClient;

@property (nonatomic, strong) NSMutableArray *data;



@end
