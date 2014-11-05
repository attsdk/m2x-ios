
#import <UIKit/UIKit.h>
#import "CBBDataSourceClient.h"

@interface BatchListViewController : UITableViewController{
    
}

@property (strong, nonatomic) CBBDataSourceClient *dataSourceClient;

@property (nonatomic, strong) NSMutableArray *data;

@end
