//
//  CBBDistributionClient.m
//  M2XLib
//
//  Created by Luis Floreani on 11/6/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBDistributionClient.h"

@implementation CBBDistributionClient

-(void)listDistributionsWithCompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/distributions";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createDistribution:(NSDictionary *)distribution completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/distributions";
    
    [[CBBM2x shared] postWithPath:path andParameters:distribution apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewDetailsForDistributionId:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDetailsForDistributionId:(NSString *)distribution_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}


-(void)listDevicesfromDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/devices",distribution_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)addDeviceToDistribution:(NSString *)distribution_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/devices",distribution_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

@end
