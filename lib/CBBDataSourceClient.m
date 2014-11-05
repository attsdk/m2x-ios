
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

-(void)listBatchWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/batches";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)createBatch:(NSDictionary *)batch success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/batches";
    
    [[CBBM2x shared] postWithPath:path andParameters:batch apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)viewDetailsForBatchId:(NSString *)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/batches/%@",batch_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)updateDetailsForBatchId:(NSString *)batch_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/batches/%@",batch_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}


-(void)listDataSourcesfromBatch:(NSString *)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/batches/%@/datasources",batch_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)addDataSourceToBatch:(NSString *)batch_id withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/batches/%@/datasources",batch_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
    
}

-(void)deleteBatch:(NSString *)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/batches/%@",batch_id];
    
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
