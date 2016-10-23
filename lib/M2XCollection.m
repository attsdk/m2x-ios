//
//  M2XCollection.m
//  M2XLib
//
//  Created by Luis Floreani on 12/29/15.
//  Copyright © 2015 citrusbyte.com. All rights reserved.
//

#import "M2XCollection.h"

static NSString * const kPath = @"/collections";

@implementation M2XCollection

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", kPath, [self[@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XCollectionCallback)completionHandler {
    [client postWithPath:kPath parameters:parameters completionHandler:^(M2XResponse *response) {
        M2XCollection *collection = [[M2XCollection alloc] initWithClient:client attributes:response.json];
        completionHandler(collection, response);
    }];
}

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:kPath parameters:parameters completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"collections"]) {
            M2XCollection *collection = [[M2XCollection alloc] initWithClient:client attributes:dict];
            [array addObject:collection];
        }
        
        completionHandler(array, response);
    }];
}

-(void)addDevice:(M2XClient *)client withDeviceId:(NSString *)deviceid completionHandler:(M2XCollectionCallback)completionHandler{
    NSString *pathByAppendingDeviceID = [NSString stringWithFormat:@"%@/devices/%@", kPath,deviceid];
    [client putWithPath:[NSString stringWithFormat:@"%@", pathByAppendingDeviceID] parameters:nil completionHandler:^(M2XResponse *response) {
        M2XCollection *collection = [[M2XCollection alloc] initWithClient:client attributes:response.json];
        completionHandler(collection, response);
    }];
}

-(void)removeDevice:(M2XClient *)client withDeviceId:(NSString *)deviceid  completionHandler:(M2XCollectionCallback)completionHandler{
    NSString *pathByAppendingDeviceID = [NSString stringWithFormat:@"%@/devices/%@", kPath,deviceid];
    [client deleteWithPath:[NSString stringWithFormat:@"%@", pathByAppendingDeviceID] parameters:nil completionHandler:^(M2XResponse *response) {
        M2XCollection *collection = [[M2XCollection alloc] initWithClient:client attributes:response.json];
        completionHandler(collection, response);
    }];
    
}

#pragma mark - metadata

- (void)metadataWithCompletionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/metadata", [self path]] parameters:nil completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

- (void)updateMetadata:(NSDictionary *)data completionHandler:(M2XResourceCallback)completionHandler {
    [self.client putWithPath:[NSString stringWithFormat:@"%@/metadata", [self path]] parameters:data completionHandler:^(M2XResponse *response) {
        completionHandler(self, response);
    }];
}

- (void)metadataField:(NSString *)field completionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/metadata/%@", [self path], field] parameters:nil completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

- (void)updateMetadataField:(NSString *)field value:(id)value completionHandler:(M2XResourceCallback)completionHandler {
    [self.client putWithPath:[NSString stringWithFormat:@"%@/metadata/%@", [self path], field] parameters:@{@"value": value} completionHandler:^(M2XResponse *response) {
        completionHandler(self, response);
    }];
}



@end
