
#import "M2x.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@interface M2x()
@property (strong, nonatomic) NSURLSession *session;
@end

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
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
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

-(void)prepareUrlRequest:(NSMutableURLRequest *)request api_key:(NSString*)api_key_used {
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    [request setValue:[NSString stringWithFormat:@"M2X/%@ (iOS %@; %@)", M2X_LIB_VERSION, [[UIDevice currentDevice] systemVersion], [self platform]] forHTTPHeaderField:@"User-Agent"];
}

-(void)prepareUrlRequest:(NSMutableURLRequest *)request parameters:(NSDictionary *)parameters {
    NSArray *keys = [parameters allKeys];
    for (NSString *key in keys) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedValue = [parameters[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (key == [keys firstObject]) {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@=%@", request.URL, encodedKey, encodedValue]];
        } else {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@=%@", request.URL, encodedKey, encodedValue]];
        }
    }
}

#pragma mark - Http methods

-(void)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request api_key:api_key_used];
    [self prepareUrlRequest:request parameters:parameters];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            failure(error, obj);
        } else {
            success(obj);
        }
    }];
    [task resume];
}

-(void)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        failure(error, nil);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request api_key:api_key_used];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            failure(error, obj);
        } else {
            success(obj);
        }
    }];
    [task resume];
}

-(void)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        failure(error, nil);
        return;
    }

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request api_key:api_key_used];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:postData];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            failure(error, obj);
        } else {
            success(obj);
        }
    }];
    [task resume];
}

-(void)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    [self prepareUrlRequest:request api_key:api_key_used];
    [self prepareUrlRequest:request parameters:parameters];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            failure(error, obj);
        } else {
            success(obj);
        }
    }];
    [task resume];
}

@end
