
#import <UIKit/UIKit.h>

@interface DistributionDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) M2XDistribution *distribution;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDataSources;

@property (weak, nonatomic) IBOutlet UILabel *lblDistributionID;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;

@end
