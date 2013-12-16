
#import <UIKit/UIKit.h>
#import "DataSourceClient.h"

@interface BatchDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) DataSourceClient *dataSourceClient;
@property (nonatomic, strong) NSString *batch_id;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDataSources;

@property (weak, nonatomic) IBOutlet UILabel *lblBatchID;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;

@end
