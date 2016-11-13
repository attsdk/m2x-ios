//
//  M2XCommand.m
//  M2X_iOS
//
//  Created by ATT SDK.
//  Copyright © 2016 AT&T. All rights reserved.
//

#import "M2XCommand.h"
static NSString * const kPath = @"/commands";

@implementation M2XCommand

- (void)listSentCommands:(M2XArrayCallback)completionHandler{
    [self.client getWithPath:[NSString stringWithFormat:@"%@",kPath ] parameters:nil completionHandler:^(M2XResponse *response) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"commands"]) {
            M2XCommand *command = [[M2XCommand alloc] initWithClient:self.client attributes:dict];
            [array addObject:command];
        }
        completionHandler(array, response);
    }];
}

- (void)sendCommand:(NSDictionary *)parameters completionHandler:(M2XBaseCallback)completionHandler{
    
    [self.client postWithPath:[NSString stringWithFormat:@"%@",kPath ] parameters:parameters completionHandler:^(M2XResponse *response) {
        {
            completionHandler(response);
        }
    }];
}

- (void)viewCommandDetails:(NSString *)identifier completionHandler:(M2XBaseCallback)completionHandler{
    
    [self.client getWithPath:[NSString stringWithFormat:@"%@/%@",kPath,identifier ] parameters:nil completionHandler:^(M2XResponse *response) {
        {
            completionHandler(response);
        }
    }];
}

@end
