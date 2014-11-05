
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CBBFeedsClient.h"

@interface FeedsListViewController : UITableViewController {
    
}
@property (strong, nonatomic) NSString *masterKey;
@property (strong, nonatomic) NSString *feedKey;
@property (strong, nonatomic) CBBFeedsClient *feedClient;

@property (nonatomic, strong) NSMutableArray *data;



@end
