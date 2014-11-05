
#import <Foundation/Foundation.h>
#import "CBBM2x.h"
#import "CBBBaseClient.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface CBBDataSourceClient : CBBBaseClient


///------------------------------------
/// @List Blueprints
///------------------------------------

/**
Retrieve list of data source blueprints accessible by the authenticated API key.
*/
-(void)listBlueprintsWithCompletionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Create Blueprint
///------------------------------------

/**
 Create a new data source blueprint.
 */
-(void)createBlueprint:(NSDictionary*)blueprint completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Blueprint Details
///------------------------------------

/**
 Retrieve information about an existing data source blueprint.
 */
-(void)viewDetailsForBlueprintId:(NSString*)blueprint_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Update Blueprint Details
///------------------------------------

/**
 Update an existing data source blueprint's information. Accepts the following parameters:
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated string of tags (optional).
 */
-(void)updateDetailsForBlueprintId:(NSString*)blueprint_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Delete Blueprint
///------------------------------------

/**
 Delete an existing data source blueprint.
 */
-(void)deleteBlueprint:(NSString*)blueprint_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @List Distributions
///------------------------------------

/**
 Retrieve list of data source distributions accessible by the authenticated API key.
 */
-(void)listDistributionWithCompletionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @Create Distribution
///------------------------------------

/**
 Create a new data source batch.
 
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
 Retrieve information about an existing data source batch.
 */
-(void)viewDetailsForDistributionId:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Update Distribution Details
///------------------------------------

/**
 Update an existing data source batch's information. Accepts the following parameters:
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated string of tags (optional).
 */
-(void)updateDetailsForDistributionId:(NSString*)batch_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @List Data Sources from a Distribution
///------------------------------------

/**
 Retrieve list of data sources added to the specified batch
 */
-(void)listDataSourcesfromDistribution:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Add Data Source to an existing Distribution
///------------------------------------

/**
 Add a new data source to an existing batch. Accepts the following parameter:
 
 "serial" data source serial number (required).
 
 NSDictionary *parameters = @{ @"serial": @"ABC1234" };
 */
-(void)addDataSourceToDistribution:(NSString*)batch_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Delete Distribution
///------------------------------------

/**
 Delete an existing data source batch.
 */
-(void)deleteDistribution:(NSString*)batch_id completionHandler:(M2XAPICallback)completionHandler;

///------------------------------------
/// @List Data Sources
///------------------------------------

/**
 Retrieve list of data sources accessible by the authenticated API key.
 */
-(void)listDataSourcesWithcompletionHandler:(M2XAPICallback)completionHandler;


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
-(void)createDataSource:(NSDictionary*)dataSource completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @View Data Source Details
///------------------------------------

/**
 Retrieve information about an existing data source.
 */
-(void)viewDetailsForDataSourceId:(NSString*)datasource_id completionHandler:(M2XAPICallback)completionHandler;


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
-(void)updateDetailsForDataSourceId:(NSString*)datasource_id withParameters:(NSDictionary*)parameters completionHandler:(M2XAPICallback)completionHandler;


///------------------------------------
/// @Delete Data Source
///------------------------------------

/**
 Delete an existing data source.
 */
-(void)deleteDatasource:(NSString*)datasource_id completionHandler:(M2XAPICallback)completionHandler;

@end
