
#import <UIKit/UIKit.h>

@interface StreamValuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) M2XStream *stream;
@property (nonatomic, strong) NSString *streamName;
@property (nonatomic, strong) NSDictionary *streamUnit;

@end
