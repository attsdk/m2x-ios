
#import <UIKit/UIKit.h>
#import "FeedsClient.h"

@interface StreamValuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FeedsClient *feedClient;
@property (nonatomic, strong) NSString *feed_id;
@property (nonatomic, strong) NSString *streamName;
@property (nonatomic, strong) NSDictionary *streamUnit;

@end
