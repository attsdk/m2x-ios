//
//  M2XResource.m
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XResource.h"

@interface M2XResource()

@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) M2XClient *client;

@end

@implementation M2XResource

- (instancetype)initWithClient:(M2XClient *)client attributes:(NSDictionary *)attributes {
    self = [super init];
    
    if (self) {
        _client = client;
        _attributes = attributes;
    }
    
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

@end
