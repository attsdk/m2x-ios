//
//  CBBResponse.h
//  M2XLib
//
//  Created by Luis Floreani on 11/27/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBBResponse : NSObject

@property (readonly) id json;
@property (readonly) NSData *raw;
@property (readonly) NSInteger status;
@property (readonly) NSDictionary *headers;
@property (readonly) BOOL success;
@property (readonly) BOOL clientError;
@property (readonly) BOOL serverError;
@property (readonly) BOOL error;
@property (readonly) NSError *errorObject;

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end
