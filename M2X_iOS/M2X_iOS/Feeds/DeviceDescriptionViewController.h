
#import <UIKit/UIKit.h>
#import "CBBDeviceClient.h"

@interface DeviceDescriptionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblDeviceId;
@property (weak, nonatomic) IBOutlet UILabel *lblCreated;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreams;

@property (nonatomic, strong) NSMutableArray *streamList;
@property (nonatomic, strong) CBBDeviceClient *deviceClient;
@property (nonatomic, strong) NSString *device_id;

@end
