
#import "DataSourceClient.h"
#import "M2x.h"

@implementation DataSourceClient

-(NSString *)getApiKey{
    return (_feed_key) ? _feed_key : [M2x shared].api_key;
}

-(void)listBlueprintsWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/blueprints";
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)createBlueprint:(NSDictionary*)blueprint success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/blueprints";
    
    [[M2x shared] postWithPath:path andParameters:blueprint api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)viewBlueprintDetails:(NSString*)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/blueprints/%@",blueprint_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}




@end
