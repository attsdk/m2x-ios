
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface KeysClient : NSObject

@end
