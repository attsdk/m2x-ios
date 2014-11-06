
#import <UIKit/UIKit.h>
#import "CBBDistributionClient.h"

@interface DistributionListViewController : UITableViewController{
    
}

@property (strong, nonatomic) CBBDistributionClient *dataSourceClient;

@property (nonatomic, strong) NSMutableArray *data;

@end
