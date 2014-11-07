//
//  CBBDistributionClient.h
//  M2XLib
//
//  Created by Luis Floreani on 11/6/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import "CBBBaseClient.h"
#import "CBBM2x.h"

@interface CBBDistributionClient : CBBBaseClient

///------------------------------------
/// @List Distributions
///------------------------------------

/**
 Retrieve list of device distributions accessible by the authenticated API key.
 */
-(void)listDistributionsWithCompletionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Create Distribution
///------------------------------------

/**
 Create a new device batch.
 
 i.e.:
 NSDictionary *key = @{ @"name": @"newDistribution",
 @"description": @"this is the description", //optional
 @"visibility": "public", //or "private"
 @"tags": @"tag1, tag2", //optional
 }
 */
-(void)createDistribution:(NSDictionary*)batch completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Distribution Details
///------------------------------------

/**
 Retrieve information about an existing device batch.
 */
-(void)viewDetailsForDistributionId:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Update Distribution Details
///------------------------------------

/**
 Update an existing device batch's information. Accepts the following parameters:
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated string of tags (optional).
 */
-(void)updateDetailsForDistributionId:(NSString*)batch_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @List Devices from a Distribution
///------------------------------------

/**
 Retrieve list of devices added to the specified batch
 */
-(void)listDevicesFromDistribution:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Add Device to an existing Distribution
///------------------------------------

/**
 Add a new device to an existing batch. Accepts the following parameter:
 
 "serial" device serial number (required).
 
 NSDictionary *parameters = @{ @"serial": @"ABC1234" };
 */
-(void)addDeviceToDistribution:(NSString*)batch_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Delete Distribution
///------------------------------------

/**
 Delete an existing device batch.
 */
-(void)deleteDistribution:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;


@end
