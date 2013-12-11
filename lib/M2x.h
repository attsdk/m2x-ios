
#import <Foundation/Foundation.h>

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface M2x : NSObject

#define API_URL @"https://api-m2x.att.com/v1"

+(M2x*) shared;

-(void)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;
-(void)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

//Parse iso8601 to NSDate  method
-(NSDate*)iSO8601ToDate:(NSString*)dateString;

@property (nonatomic,strong, getter = getApiUrl) NSString *api_url;
@property (nonatomic, retain) NSString *api_key;

@end
