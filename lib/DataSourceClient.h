
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface DataSourceClient : NSObject

/**
 *List Blueprints:
 * Retrieve list of data source blueprints accessible by the authenticated API key.
 */
-(void)listBlueprintsWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

/**
 *Create Blueprint:
 * Create a new data source blueprint.
 */
-(void)createBlueprint:(NSDictionary*)blueprint success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

/**
 *View Blueprint Details:
 * Retrieve information about an existing data source blueprint.
 */
-(void)viewDetailsForBlueprintId:(NSString*)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)updateDetailsForBlueprintId:(NSString*)blueprint_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)deleteBlueprint:(NSString*)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)listBatchWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)createBatch:(NSDictionary*)batch success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)viewDetailsForBatchId:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)updateDetailsForBatchId:(NSString*)batch_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)listDataSourcesfromBatch:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)addDataSourceToBatch:(NSString*)batch_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)deleteBatch:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)listDataSourcesWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)createDataSource:(NSDictionary*)dataSource success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)viewDetailsForDataSourceId:(NSString*)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)updateDetailsForDataSourceId:(NSString*)datasource_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

-(void)deleteDatasource:(NSString*)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


@property (nonatomic,strong) NSString *feed_key;


@end
