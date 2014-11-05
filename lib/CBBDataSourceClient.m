
#import "CBBDataSourceClient.h"
#import "CBBM2x.h"

@implementation CBBDataSourceClient

-(void)listBlueprintsWithCompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/blueprints";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createBlueprint:(NSDictionary*)blueprint completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/blueprints";
    
    [[CBBM2x shared] postWithPath:path andParameters:blueprint apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewDetailsForBlueprintId:(NSString *)blueprint_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDetailsForBlueprintId:(NSString *)blueprint_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteBlueprint:(NSString *)blueprint_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDistributionWithCompletionHandler:(M2XAPICallback)completionHandler{
    
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


-(void)listDataSourcesfromDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/datasources",distribution_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)addDataSourceToDistribution:(NSString *)distribution_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/datasources",distribution_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDistribution:(NSString *)distribution_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDataSourcesWithcompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/datasources";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createDataSource:(NSDictionary *)dataSource completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/datasources";
    
    [[CBBM2x shared] postWithPath:path andParameters:dataSource apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewDetailsForDataSourceId:(NSString *)datasource_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDetailsForDataSourceId:(NSString *)datasource_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDatasource:(NSString *)datasource_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}


@end
