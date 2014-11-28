
#import "CBBDeviceClient.h"
#import "CBBM2xClient.h"
#import "CBBM2xClient+HTTP.h"

@implementation CBBDeviceClient

-(void)listDevicesWithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [self.client getWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)listDevicesWithCompletionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)createDevice:(NSDictionary *)device completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/devices";
    
    [self.client postWithPath:path andParameters:device apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)viewDetailsForDeviceId:(NSString *)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)updateDetailsForDeviceId:(NSString *)device_id withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [self.client putWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)deleteDevice:(NSString *)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@",device_id];
    
    [self.client deleteWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)readDataLocationInDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/location",device_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)updateDeviceWithLocation:(NSDictionary*)location inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/location",device_id];
    
    [self.client putWithPath:path andParameters:location apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)listTriggersinDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers",device_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)createTrigger:(NSDictionary*)trigger inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers",device_id];
    
    [self.client postWithPath:path andParameters:trigger apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)viewTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)updateTrigger:(NSString*)trigger_id withParameters:(NSDictionary*)parameters inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [self.client putWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)testTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@/test",device_id,trigger_id];
    
    [self.client postWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)deleteTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/triggers/%@",device_id,trigger_id];
    
    [self.client deleteWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(void)viewRequestLogForDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/devices/%@/log",device_id];
    
    [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

@end
