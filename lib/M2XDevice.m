//
//  M2XDevice.m
//  M2XLib
//
//  Created by Luis Floreani on 11/28/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "M2XDevice.h"
#import "M2XStream.h"
#import "M2XCommand.h"

static NSString * const kPath = @"/devices";

@implementation M2XDevice

+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:kPath parameters:parameters completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"devices"]) {
            M2XDevice *device = [[M2XDevice alloc] initWithClient:client attributes:dict];
            [array addObject:device];
        }
        
        completionHandler(array, response);
    }];
}

+ (void)searchWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:[NSString stringWithFormat:@"%@/search", kPath] parameters:parameters completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"devices"]) {
            M2XDevice *device = [[M2XDevice alloc] initWithClient:client attributes:dict];
            [array addObject:device];
        }
        
        completionHandler(array, response);
    }];
}

+ (void)tagsWithClient:(M2XClient *)client completionHandler:(M2XBaseCallback)completionHandler {
    [client getWithPath:[NSString stringWithFormat:@"%@/tags", kPath] parameters:nil completionHandler:completionHandler];
}

+ (void)catalogWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [client getWithPath:[NSString stringWithFormat:@"%@/catalog", kPath] parameters:parameters completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"devices"]) {
            M2XDevice *device = [[M2XDevice alloc] initWithClient:client attributes:dict];
            [array addObject:device];
        }
        
        completionHandler(array, response);
    }];
}

+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XDeviceCallback)completionHandler {
    [client postWithPath:kPath parameters:parameters completionHandler:^(M2XResponse *response) {
        M2XDevice *device = [[M2XDevice alloc] initWithClient:client attributes:response.json];
        completionHandler(device, response);
    }];
}

- (void)logWithCompletionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/log", kPath] parameters:nil completionHandler:completionHandler];
}

- (void)streamsWithCompletionHandler:(M2XArrayCallback)completionHandler {
    [M2XStream listWithClient:self.client device:self completionHandler:completionHandler];
}

- (void)streamsWithName:(NSString *)name completionHandler:(M2XStreamCallback)completionHandler {
    [M2XStream fetchWithClient:self.client device:self name:name completionHandler:completionHandler];
}

- (void)updateStreamWithName:(NSString *)name parameters:(NSDictionary *)parameters completionHandler:(M2XStreamCallback)completionHandler {
    M2XStream *stream = [[M2XStream alloc] initWithClient:self.client device:self attributes:@{@"name": name}];
    [stream updateWithParameters:parameters completionHandler:completionHandler];
}

- (void)locationWithCompletionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/location", [self path]] parameters:nil completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

- (void)locationHistoryWithParameters:(NSDictionary *)parameters completionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/location/waypoints", [self path]] parameters:parameters completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

- (void)updateLocation:(NSDictionary *)parameters completionHandler:(M2XDeviceCallback)completionHandler {
    [self.client putWithPath:[NSString stringWithFormat:@"%@/location", [self path]] parameters:parameters completionHandler:^(M2XResponse *response) {
        completionHandler(self, response);
    }];
}

- (void)postUpdates:(NSDictionary *)values completionHandler:(M2XBaseCallback)completionHandler {
    [self.client postWithPath:[NSString stringWithFormat:@"%@/updates", [self path]] parameters:values completionHandler:completionHandler];
}

- (void)valuesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/values", [self path]] parameters:parameters completionHandler:^(M2XResponse *response) {
        completionHandler(response.json[@"values"], response);
    }];
}

- (void)searchValuesWithParameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/values/search", [self path]] parameters:parameters parametersAsJSONBody:YES completionHandler:^(M2XResponse *response) {
        completionHandler(response.json[@"values"], response);
    }];
}

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", kPath, [self[@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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

- (void)postDeviceUpdate:(NSDictionary *)parameters completionHandler:(M2XBaseCallback)completionHandler{
    [self.client postWithPath:[NSString stringWithFormat:@"%@/update", [self deviceUpdatepath]] parameters:parameters completionHandler:^(M2XResponse *response) {
                completionHandler(response);
           }];
    }

- (NSString *)deviceUpdatepath {
        return [NSString stringWithFormat:@"%@", self.path];
    }

-(void)exportValuesFromDataStreamCompletionHandler:(M2XBaseCallback)completionHandler {
    [self.client getWithPath:[NSString stringWithFormat:@"%@/values/%@", [self path],@"export.csv"] parameters:nil completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

-(void)deleteLocationHistory:(NSDictionary *)parameters completionHandler:(M2XBaseCallback)completionHandler {
    [self.client deleteWithPath:[NSString stringWithFormat:@"%@/location/waypoints", [self path]] parameters:parameters completionHandler:^(M2XResponse *response) {
        completionHandler(response);
    }];
}

- (void)listCommandsWitCompletionHandler:(M2XArrayCallback)completionHandler{
    [self.client getWithPath:[NSString stringWithFormat:@"%@/commands",[self path] ] parameters:nil completionHandler:^(M2XResponse *response) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in response.json[@"commands"]) {
            M2XCommand *command = [[M2XCommand alloc] initWithClient:self.client attributes:dict];
            [array addObject:command];
        }
        
        completionHandler(array, response);
    }];
}



- (void)viewCommandWithCommandId:(NSString *)commandId completionHandler:(M2XBaseCallback)completionHandler{
    [self.client getWithPath:[NSString stringWithFormat:@"%@/commands/%@",[self path],commandId ] parameters:nil completionHandler:^(M2XResponse *response) {
        {
            completionHandler(response);
        }
    }];
    
}

-(void)processCommand:(NSDictionary*)optionalParameters commandId:(NSString *)commandId completionHandler:(M2XBaseCallback)completionHandler{
    
    [self.client postWithPath:[NSString stringWithFormat:@"%@/commands/%@/process",[self path],commandId ] parameters:optionalParameters completionHandler:^(M2XResponse *response) {
        {
            completionHandler(response);
        }
    }];
    
}

- (void)rejectCommand:(NSDictionary*)optionalParameters commandId:(NSString *)commandId completionHandler:(M2XBaseCallback)completionHandler{
    
    [self.client postWithPath:[NSString stringWithFormat:@"%@/commands/%@/reject",[self path],commandId ] parameters:optionalParameters completionHandler:^(M2XResponse *response) {
        {
            completionHandler(response);
            
        }
        
    }];
    
}

@end
