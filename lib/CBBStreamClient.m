
#import "CBBStreamClient.h"
#import "CBBM2x.h"

@implementation CBBStreamClient

-(void)listDataStreamsForDeviceId:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams", device_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id WithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/values",device_id,stream];
    
    [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/values",device_id,stream];
    
    [[CBBM2x shared] postWithPath:path andParameters:values apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)postMultipleValues:(NSDictionary*)values inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/updates",device_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:values apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}



-(void)viewDataForStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDataStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

@end
