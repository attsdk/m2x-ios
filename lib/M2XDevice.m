//
//  M2XDevice.m
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XDevice.h"
#import "M2XClient+HTTP.h"

NSString * const kPath = @"/devices";

@implementation M2XDevice

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:kPath parameters:parameters apiKey:client.apiKey completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"devices"]) {
            M2XDevice *device = [[M2XDevice alloc] initWithClient:client parameters:dict];
            [array addObject:device];
        }
        
        completionHandler(array, response);
    }];
}

+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XDeviceCallback)completionHandler {
    [client postWithPath:kPath parameters:parameters apiKey:client.apiKey completionHandler:^(M2XResponse *response) {
        M2XDevice *device = [[M2XDevice alloc] initWithClient:client parameters:response.json];
        completionHandler(device, response);
    }];
}

@end
