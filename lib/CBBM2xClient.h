
#import <UIKit/UIKit.h>
#import "NSDate+M2X.h"
#import "CBBResponse.h"

typedef void (^M2XAPICallback)(CBBResponse *response);

@interface CBBM2xClient : NSObject

-(instancetype)initWithApiKey:(NSString *)apiKey;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSString *apiUrl;
@property (nonatomic, copy) NSString *apiKey;

@end
