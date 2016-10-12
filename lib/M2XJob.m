//
//  M2XJob.m
//  M2X_iOS
//
//  Created by Mohasina Musthafa on 04/10/16.
//  Copyright © 2016 AT&T. All rights reserved.
//

#import "M2XJob.h"

static NSString * const kPath = @"/jobs";

@implementation M2XJob

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", kPath, [self[@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:kPath parameters:parameters completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"jobs"]) {
            M2XJob *job = [[M2XJob alloc] initWithClient:client attributes:dict];
            [array addObject:job];
        }
        
        completionHandler(array, response);
    }];
}

@end
