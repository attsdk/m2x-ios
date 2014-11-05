
#import "KeysClient.h"
#import "M2x.h"

@implementation KeysClient

-(NSString *)getApiKey{
    
    if(!_feed_key || [_feed_key isEqualToString:@""]){
        return [M2x shared].apiKey;
    }
    
    return _feed_key;
}

-(NSURLRequest *)listKeysWithParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    return [[M2x shared] getWithPath:path andParameters:parameters apiKey:[self getApiKey] success:success failure:failure];
}

-(NSURLRequest *)createKey:(NSDictionary *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    return [[M2x shared] postWithPath:path andParameters:key apiKey:[self getApiKey] success:success failure:failure];
}

-(NSURLRequest *)viewDetailsForKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[M2x shared] getWithPath:path andParameters:nil apiKey:[self getApiKey] success:success failure:failure];
    
}

-(NSURLRequest *)updateKey:(NSString *)key withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[M2x shared] putWithPath:path andParameters:parameters apiKey:[self getApiKey] success:success failure:failure];
    
}

-(NSURLRequest *)regenerateKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@/regenerate",key];
    
    return [[M2x shared] postWithPath:path andParameters:nil apiKey:[self getApiKey] success:success failure:failure];
}

-(NSURLRequest *)deleteKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    return [[M2x shared] deleteWithPath:path andParameters:nil apiKey:[self getApiKey] success:success failure:failure];
    
}


@end
