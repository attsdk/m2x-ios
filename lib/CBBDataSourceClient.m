
#import "CBBDataSourceClient.h"
#import "CBBM2x.h"

@implementation CBBDataSourceClient

-(void)listBlueprintsWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/blueprints";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)createBlueprint:(NSDictionary*)blueprint success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/blueprints";
    
    [[CBBM2x shared] postWithPath:path andParameters:blueprint apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)viewDetailsForBlueprintId:(NSString *)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)updateDetailsForBlueprintId:(NSString *)blueprint_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)deleteBlueprint:(NSString *)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)listDistributionWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/distributions";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)createDistribution:(NSDictionary *)distribution success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/distributions";
    
    [[CBBM2x shared] postWithPath:path andParameters:distribution apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)viewDetailsForDistributionId:(NSString *)distribution_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)updateDetailsForDistributionId:(NSString *)distribution_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}


-(void)listDataSourcesfromDistribution:(NSString *)distribution_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/datasources",distribution_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)addDataSourceToDistribution:(NSString *)distribution_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@/datasources",distribution_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)deleteDistribution:(NSString *)distribution_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/distributions/%@",distribution_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)listDataSourcesWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/datasources";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)createDataSource:(NSDictionary *)dataSource success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/datasources";
    
    [[CBBM2x shared] postWithPath:path andParameters:dataSource apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)viewDetailsForDataSourceId:(NSString *)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)updateDetailsForDataSourceId:(NSString *)datasource_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)deleteDatasource:(NSString *)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/datasources/%@",datasource_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}


@end
