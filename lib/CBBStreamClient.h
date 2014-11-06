
#import <Foundation/Foundation.h>
#import "CBBM2x.h"
#import "CBBBaseClient.h"

@interface CBBStreamClient : CBBBaseClient


///------------------------------------
/// @List Data Streams
///------------------------------------

/**
 Retrieve list of data streams associated with the specified device.
 */
-(void)listDataStreamsForDeviceId:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @List Data Stream Values
///------------------------------------

/**
 List values from an existing data stream associated with a specific device, sorted in reverse chronological order (most recent values first).
 
 The values can be filtered by using one or more of the following parameters:
 
 "start" (optional)
 "end" (optional)
 "limit" (optional)
 */
-(void)listDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id WithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Post Data Stream Values
///------------------------------------

/**
 Post values to an existing data stream associated with a specific device.
 Values are passed in a values array and can be optionally timestamped. If no timestamp is specified, the current time of the API server is used.
 
 Accepted attributes for each element in the array:
 
 "timestamp" (optional)
 "value" (required)
 i.e.:
 NSDictionary *values = @{ @"values": @[
    @{ @"timestamp": @"2013-09-09T19:15:00Z", @"value": @"32" },
    @{ @"timestamp": @"2013-09-09T20:15:00Z", @"value": @"30" },
    @{ "value": "15" } ] };
 */
-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Post values to multiple streams at once.
///------------------------------------

/**
 Post values to an existing data stream associated with a specific device.
 Values are passed in a values array and can be optionally timestamped. If no timestamp is specified, the current time of the API server is used.
 
 Accepted attributes for each element in the array:
 
 "timestamp" (optional)
 "value" (required)
 i.e.:
 NSDictionary *values = @{ @"values": 
    @{ @"temperature": @[
        @{ @"timestamp": @"2013-09-09T19:15:00Z", @"value": @"32" },
        @{ @"timestamp": @"2013-09-09T20:15:00Z", @"value": @"30" },
        @{ @"value": @"15" } ],
       @"humidity": @[
    @{ @"timestamp": @"2013-09-09T19:15:00Z", @"value": @"88" },
    @{ @"timestamp": @"2013-09-09T20:15:00Z", @"value": @"60" },
    @{ @"value": @"75" } ]
    }
 }
 */
-(void)postMultipleValues:(NSDictionary*)values inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Update Data Stream
///------------------------------------

/**
 Update a data stream associated with the specified device (if a stream with this name does not exist it gets created).
 */
-(void)updateDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Create Data Stream
///------------------------------------

/**
 Create a data stream associated with the specified device.
 */
-(void)createDataForStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @View Data Stream
///------------------------------------

/**
 Get details of a specific data stream associated with an existing device.
 */
-(void)viewDataForStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Delete Data Stream
///------------------------------------

/**
 Delete an existing data stream associated with a specific device.
 */
-(void)deleteDataStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @List Triggers
///------------------------------------

/**
 Retrieve list of triggers associated with the specified device.
 */
-(void)listTriggersinDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Create Trigger
///------------------------------------

/**
 Create a new trigger associated with the specified device.
 
 i.e.:
 NSDictionary *trigger = @{ @"name": @"trigger1",
    @"stream": @"temperature",
    @"condition": @">",
    @"value": @"30",
    @"callback_url": @"http://example.com",
    @"status": @"enabled" };
 */
-(void)createTrigger:(NSDictionary*)trigger inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @View Trigger
///------------------------------------

/**
 Get details of a specific trigger associated with an existing device.
 */
-(void)viewTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Update Trigger
///------------------------------------

/**
 Update an existing trigger associated with the specified device.
 */
-(void)UpdateTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Test Trigger
///------------------------------------

/**
 Test the specified trigger by firing it with a fake value. This method can be used by developers of client applications to test the way their apps receive and handle M2X notifications.
 */
-(void)testTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Delete Trigger
///------------------------------------

/**
 Delete an existing trigger associated with a specific device.
 */
-(void)deleteTrigger:(NSString*)trigger_id inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @View Request Log
///------------------------------------

/**
 Retrieve list of HTTP requests received lately by the specified device (up to 100 entries).
 */
-(void)viewRequestLogForDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

@end
