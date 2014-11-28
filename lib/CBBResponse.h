//
//  CBBResponse.h
//  M2XLib
//
//  Created by Luis Floreani on 11/27/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    CBBM2xNoApiKey = 1,
} CBBM2xAPIErrors;

extern NSString * const CBBM2xErrorDomain;

@interface CBBResponse : NSObject

@property (readonly) NSData *raw;

// result after raw data parsed as json
@property (readonly) id json;

// HTTP status code
@property (readonly) NSInteger status;

// HTTP headers
@property (readonly) NSDictionary *headers;

@property (readonly) BOOL clientError;
@property (readonly) BOOL serverError;

@property (readonly) BOOL success;

// if clientError and serverError is false
@property (readonly) BOOL error;

// in case url session returns an error
@property (readonly) NSError *errorObject;

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end
