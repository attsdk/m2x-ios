//
//  M2XResource.m
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XResource.h"

@interface M2XResource()

@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) M2XClient *client;

@end

@implementation M2XResource

- (instancetype)initWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters {
    self = [super init];
    
    if (self) {
        _client = client;
        _parameters = parameters;
    }
    
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

@end
