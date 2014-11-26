
#import <Foundation/Foundation.h>
#import "NSDate+M2X.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface M2x : NSObject

// API URL must not have the last slash.
#define M2X_API_URL @"https://api-m2x.att.com/v1"
#define M2X_LIB_VERSION @"1.0.0"

+(M2x*) shared;

-(void)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

@property (nonatomic, strong, getter = getApiUrl) NSString *api_url;
@property (nonatomic, strong) NSString *api_key;

@end
