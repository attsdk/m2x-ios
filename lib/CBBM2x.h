
#import <UIKit/UIKit.h>
#import "NSDate+M2X.h"

typedef void (^M2XAPICallback)(id object, NSURLResponse *response, NSError *error);

typedef enum : NSInteger {
    CBBM2xNoApiKey = 1,
} CBBM2xAPIErrors;

extern NSString * const CBBM2xErrorDomain;

@interface CBBM2x : NSObject

+(CBBM2x*) shared;

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;

@property (nonatomic, copy) NSString *apiUrl;
@property (nonatomic, copy) NSString *apiKey;

@end
