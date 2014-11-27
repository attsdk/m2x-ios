//
//  CBBM2xClient+HTTP.h
//  M2X_iOS
//
//  Created by Luis Floreani on 11/27/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "CBBM2xClient.h"

@interface CBBM2xClient (HTTP)

-(NSURLRequest *)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;
-(NSURLRequest *)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters apiKey:(NSString*)apiKey completionHandler:(M2XAPICallback)completionHandler;

@end
