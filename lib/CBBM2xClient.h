
#import <UIKit/UIKit.h>
#import "NSDate+M2X.h"
#import "CBBResponse.h"

typedef void (^M2XAPICallback)(CBBResponse *response);

typedef enum : NSInteger {
    CBBM2xNoApiKey = 1,
} CBBM2xAPIErrors;

extern NSString * const CBBM2xErrorDomain;

@interface CBBM2xClient : NSObject

-(instancetype)initWithApiKey:(NSString *)apiKey;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSString *apiUrl;
@property (nonatomic, copy) NSString *apiKey;

@end
