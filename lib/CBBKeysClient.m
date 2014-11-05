
#import "CBBKeysClient.h"
#import "CBBM2x.h"

@implementation CBBKeysClient

-(NSURLRequest *)listKeysWithParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    return [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
}

-(NSURLRequest *)createKey:(NSDictionary *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    return [[CBBM2x shared] postWithPath:path andParameters:key apiKey:[self apiKey] success:success failure:failure];
}

-(NSURLRequest *)viewDetailsForKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}

-(NSURLRequest *)updateKey:(NSString *)key withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] success:success failure:failure];
    
}

-(NSURLRequest *)regenerateKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@/regenerate",key];
    
    return [[CBBM2x shared] postWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
}

-(NSURLRequest *)deleteKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] success:success failure:failure];
    
}


@end
