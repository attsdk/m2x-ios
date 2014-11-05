
#import <UIKit/UIKit.h>
#import "CBBFeedsClient.h"

@interface FeedDescriptionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblFeedId;
@property (weak, nonatomic) IBOutlet UILabel *lblCreated;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreams;

@property (nonatomic, strong) NSMutableArray *streamList;
@property (nonatomic, strong) CBBFeedsClient *feedClient;
@property (nonatomic, strong) NSString *feed_id;

@end
