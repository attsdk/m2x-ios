
#import "M2x.h"
#import "AFNetworking.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation M2x

@synthesize api_key = _api_key;
@synthesize api_url = _api_url;

+ (M2x *)shared
{
    static M2x *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[M2x alloc] init];
    });
    return shared;
}


-(id)init {
    if (self = [super init]) {
        self.api_url = M2X_API_URL;
    }
    return self;
}

-(void)setApi_url:(NSString *)api_url {
    if (api_url && ![api_url isEqualToString:@""]) {
        _api_url = [api_url stringByTrimmingCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"/ "]];        
    }
}

-(NSString *)getApiUrl{
    return _api_url;
}

-(NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

-(void)prepareRequest:(AFHTTPRequestSerializer *)request api_key:(NSString*)api_key_used {
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];

    [request setValue:[NSString stringWithFormat:@"M2X/%@ (iOS %@; %@)", M2X_LIB_VERSION, [[UIDevice currentDevice] systemVersion], [self platform]] forHTTPHeaderField:@"User-Agent"];
}

#pragma mark - Http methods

-(void)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    [self prepareRequest:request api_key:api_key_used];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager GET:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFJSONRequestSerializer serializer];
    [self prepareRequest:request api_key:api_key_used];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager POST:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFJSONRequestSerializer serializer];
    [self prepareRequest:request api_key:api_key_used];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager PUT:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    [self prepareRequest:request api_key:api_key_used];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

@end
