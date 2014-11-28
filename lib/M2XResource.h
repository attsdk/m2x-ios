//
//  M2XResource.h
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2XClient.h"

@interface M2XResource : NSObject

@property (readonly) NSDictionary *parameters;

- (instancetype)initWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters;

@end
