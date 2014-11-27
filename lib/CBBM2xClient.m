
#import "CBBM2xClient.h"
#include <sys/types.h>
#include <sys/sysctl.h>

typedef void (^configureRequestBlock)(NSMutableURLRequest *request);

// API URL must not have the last slash.
static NSString * const m2xApiURL = @"https://api-m2x.att.com/v2";
static NSString * const m2xLibVersion = @"2.0.0";

static BOOL VERBOSE_MODE = YES;

NSString * const CBBM2xErrorDomain = @"CBBM2xErrorDomain";

@interface CBBM2xClient()
@end

@implementation CBBM2xClient

-(instancetype)initWithApiKey:(NSString *)apiKey {
    if (self = [super init]) {
        self.apiKey = apiKey;
        self.apiUrl = m2xApiURL;
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

-(id)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
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
    
    NSString *agent = [NSString stringWithFormat:@"M2X-iOS/%@ (%@-%@)", m2xLibVersion, [self platform], [[UIDevice currentDevice] systemVersion]];
    [request setValue:agent forHTTPHeaderField:@"User-Agent"];
}

-(void)prepareUrlRequest:(NSMutableURLRequest *)request parameters:(NSDictionary *)parameters {
    NSArray *keys = [parameters allKeys];
    for (NSString *key in keys) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedValue = nil;
        if ([parameters[key] respondsToSelector:@selector(stringByAddingPercentEscapesUsingEncoding:)])
            encodedValue = [parameters[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        else
            encodedValue = parameters[key];
        
        if (key == [keys firstObject]) {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@=%@", request.URL, encodedKey, encodedValue]];
        } else {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@=%@", request.URL, encodedKey, encodedValue]];
        }
    }
}

-(NSURLRequest *)performRequestOnPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey configureRequestBlock:(configureRequestBlock)configureRequestBlock completionHandler:(M2XAPICallback)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.apiUrl, path]];
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
        if (completionHandler) {
            CBBResponse *r = [[CBBResponse alloc] initWithResponse:(NSHTTPURLResponse *)response data:data error:error];
            completionHandler(r);
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
            completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
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
            completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
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
            completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
        }
        return nil;
    }

    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
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
            completionHandler([[CBBResponse alloc] initWithResponse:nil data:nil error:error]);
        }
        return nil;
    }
    
    return [self performRequestOnPath:path andParameters:parameters apiKey:apiKey configureRequestBlock:^(NSMutableURLRequest *request) {
        [request setHTTPMethod:@"DELETE"];
        [self prepareUrlRequest:request parameters:parameters];
    } completionHandler:completionHandler];
}

@end
