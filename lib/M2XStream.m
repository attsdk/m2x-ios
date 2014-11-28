//
//  M2XStream.m
//  M2X_iOS
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XStream.h"
#import "M2XDevice.h"

@interface M2XStream()
@property (nonatomic, strong) M2XDevice *device;
@end

@implementation M2XStream

- (instancetype)initWithClient:(M2XClient *)client device:(M2XDevice *)device attributes:(NSDictionary *)attributes {
    self = [super initWithClient:client attributes:attributes];
    if (self) {
        _device = device;
    }
    
    return self;
}

- (instancetype)initWithClient:(M2XClient *)client attributes:(NSDictionary *)attributes {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

+ (void)listWithClient:(M2XClient *)client device:(M2XDevice *)device completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:[NSString stringWithFormat:@"%@/streams", device.path] parameters:nil apiKey:client.apiKey completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"streams"]) {
            M2XStream *stream = [[M2XStream alloc] initWithClient:client device:device attributes:dict];
            [array addObject:stream];
        }
        
        completionHandler(array, response);
    }];
}

- (void)valuesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/values", [self path]] parameters:parameters apiKey:self.client.apiKey completionHandler:^(M2XResponse *response) {
        completionHandler(response.json[@"values"], response);
    }];
}

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/streams/%@", _device.path, self[@"name"]];
}

@end
