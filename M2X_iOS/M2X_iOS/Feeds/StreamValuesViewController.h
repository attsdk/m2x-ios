
#import <UIKit/UIKit.h>
#import "CBBStreamClient.h"

@interface StreamValuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CBBStreamClient *deviceClient;
@property (nonatomic, strong) NSString *device_id;
@property (nonatomic, strong) NSString *streamName;
@property (nonatomic, strong) NSDictionary *streamUnit;

@end
