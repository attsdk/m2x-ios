//
//  CBBBaseClient.h
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBBM2xClient.h"

@interface CBBBaseClient : NSObject

-(instancetype)initWithClient:(CBBM2xClient *)client;

@property (readonly) CBBM2xClient *client;

@end
