
#import <Foundation/Foundation.h>
#import "CBBM2xClient.h"
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
-(void)listDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Post Data Stream Values
///------------------------------------

/**
 --Async method--: should return a 202, which means it was accepted but not yet created.

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
 --Async method--: should return a 202, which means it was accepted but not yet created.

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
/// @Update Data Value
///------------------------------------
/**
 --Async method--: should return a 202, which means it was accepted but not yet created.

 Update the current stream value associated with a specific device.
 Value is passed in a value dictionary and can be optionally timestamped. If no timestamp is specified, the current time of the API server is used.
 
 Accepted attributes in the dictionary:
 
 "timestamp" (optional)
 "value" (required)
 i.e.:
 NSDictionary *value = @{ @"timestamp": @"2013-09-09T19:15:00Z", @"value": @"32" };
 */
-(void)updateDataValue:(NSDictionary*)value forStream:(NSString*)stream inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Delete Data Values
///------------------------------------
/**
 Accepted attributes in the parameters:
 
 "from" (required)
 "end" (required)
 i.e.:
 NSDictionary *parameters = @{ @"from": @"2013-09-09T19:15:00Z", @"end": @"2013-09-10T19:15:00Z" };
 */
-(void)deleteDataValuesFromTheStream:(NSString*)stream inDevice:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

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
 
 Accepted attributes in the parameters dictionary:
 
 "type" (optional, can be 'numeric' or 'alphanumeric')
 "unit" (required)
 i.e.:
 NSDictionary *parameters = @{ @"unit": @{"label": "celcius", "symbol": "C"}, @"type": @"numeric" };
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

@end
