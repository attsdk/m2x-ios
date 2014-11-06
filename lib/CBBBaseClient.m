//
//  CBBBaseClient.m
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBBaseClient.h"
#import "CBBM2x.h"

@implementation CBBBaseClient

- (NSString *)apiKey {
    if(!_deviceKey || [_deviceKey isEqualToString:@""]){
        return [CBBM2x shared].apiKey;
    }
    
    return _deviceKey;
}

@end
