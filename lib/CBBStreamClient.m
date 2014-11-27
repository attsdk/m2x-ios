
#import "CBBStreamClient.h"
#import "CBBM2xClient.h"

@implementation CBBStreamClient

-(void)listDataStreamsForDeviceId:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams", device_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)listDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/values",device_id,stream];
    
    [self.client getWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/values",device_id,stream];
    
    [self.client postWithPath:path andParameters:values apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)postMultipleValues:(NSDictionary*)values inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/updates",device_id];
    
    [self.client postWithPath:path andParameters:values apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)updateDataValue:(NSDictionary*)value forStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/value",device_id,stream];
    
    [self.client putWithPath:path andParameters:value apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)deleteDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@/values",device_id,stream];
    
    [self.client deleteWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
}

-(void)updateDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [self.client putWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)createDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [self.client putWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)viewDataForStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)deleteDataStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/streams/%@",device_id,stream];
    
    [self.client deleteWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

@end
