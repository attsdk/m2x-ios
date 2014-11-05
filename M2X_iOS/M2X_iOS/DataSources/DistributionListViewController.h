
#import <UIKit/UIKit.h>
#import "CBBDataSourceClient.h"

@interface DistributionListViewController : UITableViewController{
    
}

@property (strong, nonatomic) CBBDataSourceClient *dataSourceClient;

@property (nonatomic, strong) NSMutableArray *data;

@end
