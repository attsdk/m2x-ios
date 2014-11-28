
#import <UIKit/UIKit.h>
#import "CBBKeysClient.h"

@interface KeyListViewController : UITableViewController


@property (nonatomic, strong) CBBKeysClient *keysClient;
@property (nonatomic, strong) NSMutableArray *keysArray;


@end
