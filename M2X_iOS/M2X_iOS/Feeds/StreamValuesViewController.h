
#import <UIKit/UIKit.h>
#import "CBBFeedsClient.h"

@interface StreamValuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CBBFeedsClient *feedClient;
@property (nonatomic, strong) NSString *feed_id;
@property (nonatomic, strong) NSString *streamName;
@property (nonatomic, strong) NSDictionary *streamUnit;

@end
