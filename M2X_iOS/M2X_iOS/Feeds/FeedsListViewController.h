
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "FeedsClient.h"

@interface FeedsListViewController : UITableViewController {
    
}
@property (strong, nonatomic) NSString *masterKey;
@property (strong, nonatomic) NSString *feedKey;
@property (strong, nonatomic) FeedsClient *feedClient;

@property (nonatomic, retain) NSMutableArray *data;



@end
