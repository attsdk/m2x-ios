
#import <UIKit/UIKit.h>

@interface DeviceDescriptionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblDeviceId;
@property (weak, nonatomic) IBOutlet UILabel *lblCreated;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreams;

@property (nonatomic, strong) NSMutableArray *streamList;
@property (nonatomic, strong) M2XDevice *device;

@end
