
#import <Foundation/Foundation.h>
#import "CBBM2x.h"
#import "CBBBaseClient.h"

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
