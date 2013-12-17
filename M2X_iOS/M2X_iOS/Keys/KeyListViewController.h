
#import <UIKit/UIKit.h>
#import "KeysClient.h"

@interface KeyListViewController : UITableViewController


@property (nonatomic, strong) KeysClient *keysClient;
@property (nonatomic, strong) NSMutableArray *keysArray;


@end
