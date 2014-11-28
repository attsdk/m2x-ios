//
//  CBBDistributionClient.m
//  M2XLib
//
//  Created by Luis Floreani on 11/6/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBDistributionClient.h"
#import "CBBM2xClient+HTTP.h"

@implementation CBBDistributionClient

-(void)listDistributionsWithCompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/distributions";
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)createDistribution:(NSDictionary *)distribution completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/distributions";
    
    [self.client postWithPath:path andParameters:distribution apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)viewDetailsForDistributionId:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)updateDetailsForDistributionId:(NSString *)distribution_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [self.client putWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}


-(void)listDevicesFromDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/devices",distribution_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)addDeviceToDistribution:(NSString *)distribution_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/devices",distribution_id];
    
    [self.client postWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)deleteDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [self.client deleteWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

@end
