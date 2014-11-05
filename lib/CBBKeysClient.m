
#import "CBBKeysClient.h"
#import "CBBM2x.h"

@implementation CBBKeysClient

-(NSURLRequest *)listKeysWithParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/keys";
    
    return [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
}

-(NSURLRequest *)createKey:(NSDictionary *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/keys";
    
    return [[CBBM2x shared] postWithPath:path andParameters:key apiKey:[self apiKey] completionHandler:completionHandler];
}

-(NSURLRequest *)viewDetailsForKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(NSURLRequest *)updateKey:(NSString *)key withParameters:(NSDictionary *)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(NSURLRequest *)regenerateKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@/regenerate",key];
    
    return [[CBBM2x shared] postWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
}

-(NSURLRequest *)deleteKey:(NSString *)key completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}


@end
