//
//  M2XClient.m
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XClient.h"
#import "M2XDevice.h"
#import <UIKit/UIKit.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "M2XKey.h"

static NSString * const kDefaultApiBase = @"https://api-m2x.att.com";
static NSString * const kDefaultApiVersion = @"v2";
static NSString * const kLibVersion = @"2.0.0";

@implementation M2XClient

- (instancetype)initWithApiKey:(NSString *)apiKey {
    self = [super init];
    
    if (self) {
        _apiKey = apiKey;
        _apiBaseUrl = kDefaultApiBase;
        _apiVersion = kDefaultApiVersion;
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

- (void)devicesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [M2XDevice listWithClient:self parameters:parameters completionHandler:completionHandler];
}

- (void)deviceWithId:(NSString *)identifier completionHandler:(M2XDeviceCallback)completionHandler {
    [M2XDevice createWithClient:self parameters:@{@"id": identifier} completionHandler:completionHandler];
}

- (void)keysWithCompletionHandler:(M2XArrayCallback)completionHandler {
    [M2XKey listWithClient:self parameters:nil completionHandler:completionHandler];
}

- (void)createKeyWithParameters:(NSDictionary *)parameters completionHandler:(M2XKeyCallback)completionHandler {
    [M2XKey createWithClient:self parameters:parameters completionHandler:completionHandler];
}

- (NSString *)apiUrl {
    return [NSString stringWithFormat:@"%@/%@", _apiBaseUrl, _apiVersion];
}

- (NSString *)userAgent {
    return [NSString stringWithFormat:@"M2X-iOS/%@ (%@-%@)", kLibVersion, [self platform], [[UIDevice currentDevice] systemVersion]];
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

@end
