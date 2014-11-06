
#import <UIKit/UIKit.h>
#import "CBBDistributionClient.h"

@interface DistributionDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) CBBDistributionClient *dataSourceClient;
@property (nonatomic, strong) NSString *distribution_id;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDataSources;

@property (weak, nonatomic) IBOutlet UILabel *lblDistributionID;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;

@end
