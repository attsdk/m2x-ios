//
//  CBBBaseClient.h
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBBBaseClient : NSObject

@property (nonatomic, copy) NSString *deviceKey;

- (NSString *)apiKey;

@end
