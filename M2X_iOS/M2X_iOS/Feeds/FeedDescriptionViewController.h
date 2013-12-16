
#import <UIKit/UIKit.h>
#import "FeedsClient.h"

@interface FeedDescriptionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblFeedId;
@property (weak, nonatomic) IBOutlet UILabel *lblCreated;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreams;

@property (nonatomic, retain) NSMutableArray *streamList;
@property (nonatomic, strong) FeedsClient *feedClient;
@property (nonatomic, strong) NSString *feed_id;

@end
