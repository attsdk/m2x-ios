//
//  M2XJob.m
//  M2X_iOS
//
//  Created by ATT SDK on 10/28/16.
//  Copyright © 2016 AT&T. All rights reserved.
//

#import "M2XJob.h"

static NSString * const kPath = @"/jobs";

@implementation M2XJob

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", kPath, [self[@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+(void)listOfJobs:(M2XClient *)client CompletionHandler:(M2XArrayCallback)completionHandler{
    
    [client getWithPath:[NSString stringWithFormat:@"%@/", kPath] parameters:nil completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"jobs"]) {
            M2XJob *job = [[M2XJob alloc] initWithClient:client attributes:dict];
            [array addObject:job];
        }
        
        completionHandler(array, response);
    }];
    
}

-(void)viewJob:(NSString*)jobID CompletionHandler:(M2XBaseCallback)completionHandler{
    
    [self.client getWithPath:[NSString stringWithFormat:@"%@/%@", kPath,jobID] parameters:nil completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

@end
