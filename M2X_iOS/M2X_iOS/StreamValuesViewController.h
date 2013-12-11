
#import <UIKit/UIKit.h>
#import "FeedsClient.h"

@interface StreamValuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *tfNewValue;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStreamValues;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;

@property (nonatomic, retain) NSMutableArray *valueList;
@property (nonatomic, strong) FeedsClient *feedClient;
@property (nonatomic, strong) NSString *feed_id;
@property (nonatomic, strong) NSString *streamName;
@property (nonatomic, strong) NSDictionary *streamUnit;



@end
