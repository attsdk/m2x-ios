//
//  M2XDistribution.h
//  M2XLib
//
//  Created by Luis Floreani on 12/1/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XResource.h"

@interface M2XDistribution : M2XResource

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;
+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XDistributionCallback)completionHandler;

- (void)devicesWithCompletionHandler:(M2XArrayCallback)completionHandler;
- (void)addDevice:(NSString *)serial completionHandler:(M2XDeviceCallback)completionHandler;

@end
