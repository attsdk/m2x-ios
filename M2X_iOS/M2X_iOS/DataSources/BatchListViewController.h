
#import <UIKit/UIKit.h>
#import "DataSourceClient.h"

@interface BatchListViewController : UITableViewController{
    
}

@property (strong, nonatomic) DataSourceClient *dataSourceClient;

@property (nonatomic, strong) NSMutableArray *data;

@end
