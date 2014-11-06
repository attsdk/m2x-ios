
#import <Foundation/Foundation.h>
#import "CBBM2x.h"
#import "CBBBaseClient.h"

@interface CBBDeviceClient : CBBBaseClient

///------------------------------------
/// @List/Search Devices
///------------------------------------

/**
 The list of devices can be filtered by using one or more of the following parameters:
 
 "q": Text to search (optional). Only those devices containing this text in its name or description will be returned.
 "type" (optional): If passed, only devices of this type will be returned. Possible values are "distribution" and "device".
 "page": Page number to be retrieved.
 "limit": Number of devices to return per page.
 "tags" A comma delimited tags list.
 
 Devices can be searched by location by using the parameters below:
 
 "latitude"
 "longitude"
 "distance" a numeric value specified in distance_units.
 "distance_unit" either mi, miles or km.
 */
-(void)listDevicesWithParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @List Data Sources
///------------------------------------

/**
 Retrieve list of data sources accessible by the authenticated API key.
 */
-(void)listDevicesWithCompletionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Create Data Source
///------------------------------------

/**
 Create a new data source. Accepts the following parameters:
 
 "name" the name of the new data source (required).
 "description" containing a longer description (optional).
 "visibility" either "public" or "private".
 "tags" a comma separated list of tags (optional).
 */
-(void)createDevice:(NSDictionary*)device completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Data Source Details
///------------------------------------

/**
 Retrieve information about an existing data source.
 */
-(void)viewDetailsForDeviceId:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Data Source Details
///------------------------------------

/**
 Update an existing data source's information. Accepts the following parameters:
 
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated list of tags (optional).
 */
-(void)updateDetailsForDeviceId:(NSString*)device_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Delete Data Source
///------------------------------------

/**
 Delete an existing data source.
 */
-(void)deleteDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Read Device Location
///------------------------------------

/**
 Get location details of the device associated with a specific device.
 */
-(void)readDataLocationInDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Update Device Location
///------------------------------------

/**
 Update the current location of the device associated with the specified device. Accepts the following parameters:
 
 "name" a name identifying this location (optional).
 "latitude" (required)
 "longitude" (required)
 "elevation" (optional)
 */
-(void)updateDeviceWithLocation:(NSDictionary*)location inDevice:(NSString*)device_id completionHandler:(M2XAPICallback)completionHandler;


@end
