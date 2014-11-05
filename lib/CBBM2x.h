
#import <UIKit/UIKit.h>
#import "NSDate+M2X.h"

//typedef void (^M2XAPIClientSuccessObject)(id object);
//typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);
typedef void (^M2XAPICallback)(id object, NSURLResponse *response, NSError *error);

enum {
    CBBM2xNoApiKey = 1,
};

@interface CBBM2x : NSObject

+(CBBM2x*) shared;

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used completionHandler:(M2XAPICallback)completionHandler;

@property (nonatomic, copy) NSString *apiUrl;
@property (nonatomic, copy) NSString *apiKey;

@end
