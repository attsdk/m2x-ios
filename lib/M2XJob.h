//
//  M2XJob.h
//  M2X_iOS
//
//  Created by ATT SDK on 04/10/16.
//  Copyright © 2016 AT&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M2XJob : M2XResource

// Retrieve the list of jobs accessible by the authenticated API key
//
// https://m2x.att.com/developer/documentation/v2/collections#List-collections
+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;

@end
