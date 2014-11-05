
#import <UIKit/UIKit.h>
#import "NSDate+M2X.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

enum {
    CBBM2xNoApiKey = 1,
};

@interface CBBM2x : NSObject

+(CBBM2x*) shared;

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

@property (nonatomic, copy) NSString *apiUrl;
@property (nonatomic, copy) NSString *apiKey;

@end
