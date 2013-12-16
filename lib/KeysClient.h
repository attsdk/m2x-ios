
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface KeysClient : NSObject

-(void)listKeysWithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)createKey:(NSDictionary*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)viewDetailsForKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)updateKey:(NSString*)key withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)regenerateKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)deleteKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

@property (nonatomic,strong) NSString *feed_key;

@end
