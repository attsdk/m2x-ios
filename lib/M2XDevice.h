//
//  M2XDevice.h
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2XResource.h"

@interface M2XDevice : M2XResource

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;
+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XDeviceCallback)completionHandler;

- (void)streamsWithCompletionHandler:(M2XArrayCallback)completionHandler;
- (void)locationWithCompletionHandler:(M2XBaseCallback)completionHandler;
- (void)updateStreamWithName:(NSString *)name parameters:(NSDictionary *)parameters completionHandler:(M2XStreamCallback)completionHandler;

- (void)updateLocation:(NSDictionary *)parameters completionHandler:(M2XDeviceCallback)completionHandler;

- (void)triggersWithCompletionHandler:(M2XArrayCallback)completionHandler;
- (void)createTrigger:(NSDictionary *)parameters withCompletionHandler:(M2XTriggerCallback)completionHandler;

@end
