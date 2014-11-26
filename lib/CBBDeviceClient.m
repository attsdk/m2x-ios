
#import "CBBDeviceClient.h"
#import "CBBM2x.h"

@implementation CBBDeviceClient

-(void)listDevicesWithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDevicesWithCompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createDevice:(NSDictionary *)device completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [[CBBM2x shared] postWithPath:path andParameters:device apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewDetailsForDeviceId:(NSString *)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDetailsForDeviceId:(NSString *)device_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDevice:(NSString *)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)readDataLocationInDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/location",device_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDeviceWithLocation:(NSDictionary*)location inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/location",device_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:location apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listTriggersinDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers",device_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createTrigger:(NSDictionary*)trigger inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers",device_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:trigger apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateTrigger:(NSString*)trigger_id withParameters:(NSDictionary*)parameters inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)testTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@/test",device_id,trigger_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewRequestLogForDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/log",device_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

@end
