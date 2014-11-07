
#import "CBBM2x.h"
#include <sys/types.h>
#include <sys/sysctl.h>

typedef void (^configureRequestBlock)(NSMutableURLRequest *request);

// API URL must not have the last slash.
static NSString * const m2xApiURL = @"https://api-m2x.att.com/v2";
static NSString * const m2xLibVersion = @"2.0";

static BOOL VERBOSE_MODE = YES;

NSString * const CBBM2xErrorDomain = @"CBBM2xErrorDomain";

@interface CBBM2x()
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

-(void)prepareUrlRequest:(NSMutableURLRequest *)request apiKey:(NSString*)apiKey {
    [request setValue:apiKey forHTTPHeaderField:@"X-M2X-KEY"];
    
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

-(NSURLRequest *)performRequestOnPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey configureRequestBlock:(configureRequestBlock)configureRequestBlock completionHandler:(M2XAPICallback)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [CBBM2x shared].apiUrl, path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self prepareUrlRequest:request apiKey:apiKey];
    if (configureRequestBlock) {
        configureRequestBlock(request);
    }
    
    if (!completionHandler) {
        return request;
    }
    
    if (VERBOSE_MODE) {
        NSLog(@"M2X: %@", request.URL);
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        id obj = nil;
        if ([data length] > 0) {
            obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        }
        if (completionHandler) {
            if (!error) {
                NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                if (r.statusCode >= 400) {
                    error = [NSError errorWithDomain:CBBM2xErrorDomain code:CBBM2xRequestError userInfo:@{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"HTTP error code: %d", (int)r.statusCode]}];
                }
            }
            completionHandler(obj, (NSHTTPURLResponse *)response, error ? error : jsonError);
        }
    }];
    [task resume];
    
    return request;
}

#pragma mark - Http methods

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler {
    if (!apiKey) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:CBBM2xNoApiKey userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
        return nil;
    }
    
    return [self performRequestOnPath:path andParameters:parameters apiKey:apiKey configureRequestBlock:^(NSMutableURLRequest *request) {
        [self prepareUrlRequest:request parameters:parameters];
    } completionHandler:completionHandler];
}

-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler {
    if (!apiKey) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        completionHandler(nil, nil, error);
        return nil;
    }
    
    return [self performRequestOnPath:path andParameters:parameters apiKey:apiKey configureRequestBlock:^(NSMutableURLRequest *request) {
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
    } completionHandler:completionHandler];
}

-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler {
    if (!apiKey) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        completionHandler(nil, nil, error);
        return nil;
    }

    return [self performRequestOnPath:path andParameters:parameters apiKey:apiKey configureRequestBlock:^(NSMutableURLRequest *request) {
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"PUT"];
        [request setHTTPBody:postData];
    } completionHandler:completionHandler];
}

-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler {
    if (!apiKey) {
        NSError *error = [NSError errorWithDomain:CBBM2xErrorDomain code:100 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Missing API key"}];
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
        return nil;
    }
    
    return [self performRequestOnPath:path andParameters:parameters apiKey:apiKey configureRequestBlock:^(NSMutableURLRequest *request) {
        [request setHTTPMethod:@"DELETE"];
        [self prepareUrlRequest:request parameters:parameters];
    } completionHandler:completionHandler];
}

@end
