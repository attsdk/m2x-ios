
#import "CBBM2x.h"
#include <sys/types.h>
#include <sys/sysctl.h>

// API URL must not have the last slash.
static NSString * const m2xApiURL = @"https://api-m2x.att.com/v1";
static NSString * const m2xLibVersion = @"1.0";

static NSString * const CBBM2xErrorDomain = @"CBBM2xErrorDomain";

@interface CBBM2x()
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation CBBM2x

+ (CBBM2x *)shared
{
    static CBBM2x *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CBBM2x alloc] init];
    });
    return shared;
}


-(id)init {
    if (self = [super init]) {
        self.apiUrl = m2xApiURL;
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
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

-(void)prepareUrlRequest:(NSMutableURLRequest *)request apiKey:(NSString*)apiKey_used {
    [request setValue:apiKey_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    [request setValue:[NSString stringWithFormat:@"M2X/%@ (iOS %@; %@)", m2xLibVersion, [[UIDevice currentDevice] systemVersion], [self platform]] forHTTPHeaderField:@"User-Agent"];
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

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure {
    if (!apiKey_used) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:CBBM2xNoApiKey userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (failure) {
            failure(error, nil);            
        }
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [CBBM2x shared].apiUrl, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request apiKey:apiKey_used];
    [self prepareUrlRequest:request parameters:parameters];
    
    if (!success) {
        return request;
    }

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            if (failure) {
                failure(error, obj);
            }
        } else {
            success(obj);
        }
    }];
    [task resume];
    
    return request;
}

-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:
(M2XAPIClientFailureError)failure {
    if (!apiKey_used) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (failure) {
            failure(error, nil);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        failure(error, nil);
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [CBBM2x shared].apiUrl, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request apiKey:apiKey_used];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    if (!success) {
        return request;
    }

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            if (failure) {
                failure(error, obj);
            }
        } else {
            success(obj);
        }
    }];
    [task resume];
    
    return request;
}

-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure {
    if (!apiKey_used) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (failure) {
            failure(error, nil);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        failure(error, nil);
        return nil;
    }

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [CBBM2x shared].apiUrl, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request apiKey:apiKey_used];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:postData];
    
    if (!success) {
        return request;
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            if (failure) {
                failure(error, obj);
            }
        } else {
            success(obj);
        }
    }];
    [task resume];
    
    return request;
}

-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure {
    if (!apiKey_used) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (failure) {
            failure(error, nil);
        }
        return nil;
    }

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [CBBM2x shared].apiUrl, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    [self prepareUrlRequest:request apiKey:apiKey_used];
    [self prepareUrlRequest:request parameters:parameters];
    
    if (!success) {
        return request;
    }

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (error) {
            if (failure) {
                failure(error, obj);
            }
        } else {
            success(obj);
        }
    }];
    [task resume];
    
    return request;
}

@end
