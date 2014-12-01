//
//  M2XClient.h
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2XResponse.h"

@class M2XDevice;
@class M2XStream;
@class M2XKey;
@class M2XResource;
@class M2XDistribution;

typedef void (^M2XBaseCallback)(M2XResponse *response);
typedef void (^M2XResourceCallback)(M2XResource *resource, M2XResponse *response);
typedef void (^M2XDeviceCallback)(M2XDevice *device, M2XResponse *response);
typedef void (^M2XStreamCallback)(M2XStream *stream, M2XResponse *response);
typedef void (^M2XKeyCallback)(M2XKey *key, M2XResponse *response);
typedef void (^M2XDistributionCallback)(M2XDistribution *key, M2XResponse *response);
typedef void (^M2XArrayCallback)(NSArray *objects, M2XResponse *response);

@interface M2XClient : NSObject

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *apiBaseUrl;
@property (nonatomic, copy) NSString *apiVersion;
@property (nonatomic, strong) NSURLSession *session;

+ (NSString *)version;

- (instancetype)initWithApiKey:(NSString *)apiKey;

// devices
- (void)devicesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;
- (void)deviceWithId:(NSString *)identifier completionHandler:(M2XDeviceCallback)completionHandler;

// keys
- (void)keysWithCompletionHandler:(M2XArrayCallback)completionHandler;
- (void)createKeyWithParameters:(NSDictionary *)parameters completionHandler:(M2XKeyCallback)completionHandler;

// distributions
- (void)distributionsWithCompletionHandler:(M2XArrayCallback)completionHandler;
- (void)createDistributionWithParameters:(NSDictionary *)parameters completionHandler:(M2XDistributionCallback)completionHandler;

- (NSString *)userAgent;
- (NSString *)apiUrl;

@end
