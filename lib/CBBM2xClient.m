
#import "CBBM2xClient.h"

// API URL must not have the last slash.
static NSString * const m2xApiURL = @"https://api-m2x.att.com/v2";

@interface CBBM2xClient()
@end

@implementation CBBM2xClient

-(instancetype)initWithApiKey:(NSString *)apiKey {
    if (self = [super init]) {
        self.apiKey = apiKey;
        self.apiUrl = m2xApiURL;
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

-(id)init {
    @throw [NSException exceptionWithName:@"InvalidInitializer" reason:@"Can't use the default initializer" userInfo:nil];
}

@end
