
#import <UIKit/UIKit.h>
#import "DataSourceClient.h"

@interface BatchListViewController : UITableViewController{
    
}

@property (strong, nonatomic) DataSourceClient *dataSourceClient;

@property (nonatomic, retain) NSMutableArray *data;
@end
