
#import <UIKit/UIKit.h>
#import "DataSourceClient.h"

@interface BatchListViewController : UITableViewController{
    
}

@property (strong, nonatomic) NSString *masterKey;
@property (strong, nonatomic) NSString *feedKey;
@property (strong, nonatomic) DataSourceClient *dataSourceClient;

@property (nonatomic, retain) NSMutableArray *data;
@end
