//
//  CBBResponse.m
//  M2XLib
//
//  Created by Luis Floreani on 11/27/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBResponse.h"

@interface CBBResponse()

@property (strong) NSHTTPURLResponse *response;
@property (strong) NSData *data;
@property (nonatomic, strong) NSError *errorObject;

@end

@implementation CBBResponse

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {
    self = [super init];
    
    if (self) {
        _response = response;
        _data = data;
        _errorObject = error;
    }
    
    return self;
}

- (NSData *)raw {
    return _data;
}

- (id)json {
    id obj = nil;
    if ([_data length] > 0) {
        obj = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    }
    
    return obj;
}

- (NSInteger)status {
    return _response.statusCode;
}

- (NSDictionary *)headers {
    return _response.allHeaderFields;
}

- (BOOL)success {
    return _response.statusCode >= 200 && _response.statusCode <= 299;
}

- (BOOL)clientError {
    return _errorObject || (_response.statusCode >= 400 && _response.statusCode <= 499);
}

- (BOOL)serverError {
    return _errorObject || (_response.statusCode >= 500 && _response.statusCode <= 599);
}

- (BOOL)error {
    return self.clientError || self.serverError;
}

@end
