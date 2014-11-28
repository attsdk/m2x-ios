//
//  M2XStream.h
//  M2X_iOS
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XResource.h"

@interface M2XStream : M2XResource

+ (void)listWithClient:(M2XClient *)client device:(M2XDevice *)device completionHandler:(M2XArrayCallback)completionHandler;

- (void)valuesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;

@end
