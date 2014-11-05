
#import "CBBFeedsClient.h"
#import "CBBM2x.h"

@implementation CBBFeedsClient

-(void)listWithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = @"/feeds";
    
    [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewDetailsForFeedId:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@", feed_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDataStreamsForFeedId:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams", feed_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listDataValuesFromTheStream:(NSString*)stream inFeed:(NSString*)feed_id WithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@/values",feed_id,stream];
    
    [[CBBM2x shared] getWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@/values",feed_id,stream];
    
    [[CBBM2x shared] postWithPath:path andParameters:values apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)postMultipleValues:(NSDictionary*)values inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@",feed_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:values apiKey:[self apiKey] completionHandler:completionHandler];
    
}


-(void)readDataLocationInFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/location",feed_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDatasourceWithLocation:(NSDictionary*)location inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/location",feed_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:location apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)updateDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[CBBM2x shared] putWithPath:path andParameters:parameters apiKey:[self apiKey] completionHandler:completionHandler];
    
}



-(void)viewDataForStream:(NSString*)stream inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteDataStream:(NSString*)stream inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[CBBM2x shared] deleteWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)listTriggersinFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{

    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers",feed_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)createTrigger:(NSDictionary*)trigger inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers",feed_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:trigger apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@",feed_id,trigger_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)UpdateTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@",feed_id,trigger_id];
    
    [[CBBM2x shared] putWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)testTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@/test",feed_id,trigger_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)deleteTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@/test",feed_id,trigger_id];
    
    [[CBBM2x shared] postWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

-(void)viewRequestLogForFeed:(NSString*)feed_id completionHandler:(M2XAPICallback)completionHandler{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/log",feed_id];
    
    [[CBBM2x shared] getWithPath:path andParameters:nil apiKey:[self apiKey] completionHandler:completionHandler];
    
}

@end
