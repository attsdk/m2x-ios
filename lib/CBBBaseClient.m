//
//  CBBBaseClient.m
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBBaseClient.h"
#import "CBBM2xClient.h"

@interface CBBBaseClient()

@property (strong) CBBM2xClient *client;

@end

@implementation CBBBaseClient

-(instancetype)initWithClient:(CBBM2xClient *)client {
    self = [super init];
    
    if (self) {
        _client = client;
    }
    
    return self;
}

-(id)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

@end
