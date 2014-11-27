
#import <Foundation/Foundation.h>
#import "CBBM2xClient.h"
#import "CBBBaseClient.h"

@interface CBBKeysClient : CBBBaseClient


///------------------------------------
/// @List Keys
///------------------------------------

/**
 Retrieve list of keys associated with the specified account. This method accepts one optional parameter:
 "device": a Device ID; it will list all the keys that are associated with that specific device or its streams
 */
-(NSURLRequest *)listKeysWithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Create Key
///------------------------------------

/**
 Create a new key associated with the specified account.
 
 i.e.:
 NSDictionary *key = @{ @"name": @"newkey",
                 "@permissions": @[@"GET", @"PUT"],
                        @"device": [NSNull null], //optional
                      @"stream": [NSNull null], //optional
                  @"expires_at": [NSNull null]  //optional
                       }
 
 */
-(NSURLRequest *)createKey:(NSDictionary*)key completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Key Details
///------------------------------------

/**
 Get details of a specific key associated with a developer account.
 */
-(NSURLRequest *)viewDetailsForKey:(NSString*)key completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Update Key
///------------------------------------

/**
 Update name or permissions of an existing key associated with the specified account. Same validations as in Create Key applies.
 */
-(NSURLRequest *)updateKey:(NSString*)key withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Regenerate Key
///------------------------------------

/**
 Regenerate the specified key.
 */
-(NSURLRequest *)regenerateKey:(NSString*)key completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Delete Key
///------------------------------------

/**
 Delete an existing key.
 */
-(NSURLRequest *)deleteKey:(NSString*)key completionHandler:(M2XAPICallback)completionHandler;

@end
