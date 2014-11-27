
#import "CBBKeysClient.h"
#import "CBBM2xClient.h"
#import "CBBM2xClient+HTTP.h"

@implementation CBBKeysClient

-(NSURLRequest *)listKeysWithParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/keys";
    
    return [self.client getWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
}

-(NSURLRequest *)createKey:(NSDictionary *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/keys";
    
    return [self.client postWithPath:path andParameters:key apiKey:self.client.apiKey completionHandler:completionHandler];
}

-(NSURLRequest *)viewDetailsForKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [self.client getWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(NSURLRequest *)updateKey:(NSString *)key withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [self.client putWithPath:path andParameters:parameters apiKey:self.client.apiKey completionHandler:completionHandler];
    
}

-(NSURLRequest *)regenerateKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@/regenerate",key];
    
    return [self.client postWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
}

-(NSURLRequest *)deleteKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [self.client deleteWithPath:path andParameters:nil apiKey:self.client.apiKey completionHandler:completionHandler];
    
}


@end
