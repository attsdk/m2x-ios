# iOS M2X API Client

The AT&T [M2X API](https://m2x.att.com/developer/documentation/overview) provides all the needed operations to connect your devices to AT&T's M2X service. This client provides an easy to use interface for your favorite mobile platform, [iOS](https://developer.apple.com/programs/ios/).

## Getting Started

- Signup for an M2X Account: [https://m2x.att.com/signup](https://m2x.att.com/signup)
- Obtain your Master Key from the Master Keys tab of your Account Settings: [https://m2x.att.com/account](https://m2x.att.com/account)
- Create your first Data Source Blueprint and copy its Feed ID: [https://m2x.att.com/blueprints](https://m2x.att.com/blueprints)
- Review the M2X API Documentation: [https://m2x.att.com/developer/documentation/overview](https://m2x.att.com/developer/documentation/overview)

If you have questions about any M2X specific terms, please consult the M2X glossary: https://m2x.att.com/developer/documentation/glossary

##Installation

Copy the content from the `lib` folder to your project.

Note: The `lib` folder contains the AFNetworking library to make HTTP requests.

## Requirements and Dependencies

The M2X iOS Client was developed in **iOS SDK 7.0**.

The client has the following library dependency:

* AFNetworking, 2.0, [https://github.com/AFNetworking/AFNetworking](https://github.com/AFNetworking/AFNetworking)

## Architecture

Currently, the client supports M2X API v1. All M2X API specifications can be found in the [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

### M2X Class

M2X is the main class that provides the methods to set the API URL ("http://api-m2x.att.com/v1" as default) and the Master Key.

**Example:**

```objc
//get singleton instance of M2x Class
M2x* m2x = [M2x shared];
//set the Master Api Key
m2x.api_key = @"your_api_key";
```

### M2X Categories

M2X includes the NSDate+M2X category to make it easier to send and receive dates using the ISO8601 standard.

```objc
- (NSString *) toISO8601;
+ (NSDate *) fromISO8601:(NSString *)dateString;
```

These methods can be used to convert to and from a NSDate or NSString object.

**Example:**

```objc
NSDate *batchCreationDate = [NSDate fromISO8601:batch[@"created"]];
```

### API Clients
---
The clients (`FeedsClient`, `DataSourceClient` and `KeysClient`) provide an interface to make all the requests on the respectives API.

If the call requires parameters, it must be encapsulated in a `NSDictionary` following the respective estructure from the [API Documentation](https://m2x.att.com/developer/documentation/overview).
As well as the parameters, the response is returned in a `NSDictionary` object.

If required, a [Feed API key](https://m2x.att.com/developer/documentation/overview#API-Keys) can be set in these classes.

#### [FeedsClient](/lib/FeedsClient.h) ([Spec](https://m2x.att.com/developer/documentation/feed))

```objc
FeedsClient *feedClient = [[FeedsClient alloc] init];
[feedClient setFeed_key:@"YOUR_FEED_API_KEY"];
```

**List Feeds in a `NSMutableArray`:**

```objc

// Note that for this call you need your Master API Key,
// otherwise you'll get a 401 Unauthorized error.
[feedClient setFeed_key:@"YOUR_MASTER_API_KEY"];

//retrieve a list of feeds without parameters
[feedClient listWithParameters:nil success:^(id object) {

  NSDictionary *response = [value objectForKey:@"feeds"];
  feedList = [NSMutableArray array];
  for (NSDictionary *feed in response) {
      //show only active feeds
      if([[feed valueForKey:@"status"] isEqualToString:@"enabled"])
          [feedList addObject:feed];
  }

} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error description]);
    NSLog(@"Message: %@",message);
}];
```

**Update the current location:**

```objc
//init locationManager
CLLocationManager *locationManager = [[CLLocationManager alloc] init];
locationManager.distanceFilter = kCLDistanceFilterNone;
locationManager.desiredAccuracy = kCLLocationAccuracyBest;
[locationManager startUpdatingLocation];
//...//
//Set the current location
CLLocation *location = [locationManager location];
NSDictionary *locationDict = @{ @"name": _currentLocality,
                            @"latitude": [NSString stringWithFormat:@"%f",location.coordinate.latitude],
                           @"longitude": [NSString stringWithFormat:@"%f",location.coordinate.longitude],
                           @"elevation": [NSString stringWithFormat:@"%f",location.altitude] };

[feedClient updateDatasourceWithLocation:locationDict inFeed:@"your_feed_id" success:^(id object) {
	//Callback function
    [self didSetLocation];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Post Data Stream Values:**

```objc
NSDictionary *newValue = @{ @"values": @[ @{ @"value": @"20" } ] };

[feedClient postDataValues:newValue
                  forStream:@"stream_name"
                     inFeed:@"your_feed_id"
                     success:^(id object) { /*success block*/ }
                     failure:^(NSError *error, NSDictionary *message)
{
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Create a Trigger**

```objc
NSDictionary *trigger = @{ @"name": @"trigger1",
                           @"stream": @"temperature",
                           @"condition": @">",
                           @"value": @"30",
                           @"callback_url": @"http://example.com",
                           @"status": @"enabled" };

[feedClient createTrigger:trigger inFeed:@"ee9501931bcb3f9b0d25fde5eaf4abd8" success:^(id object) {
    /*success block*/
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**View Request Log**

```objc
[feedClient viewRequestLogForFeed:@"YOUR_FEED_ID" success:^(id object) {
  NSArray *requests = [object objectForKey:@"requests"];
} failure:^(NSError *error, NSDictionary *message) {
  NSLog(@"error: %@",[error localizedDescription]);
  NSLog(@"Message: %@",message);
}];
```

#### [DataSourceClient](/lib/DataSourceClient.h) ([Spec](https://m2x.att.com/developer/documentation/datasource))


```objc
DataSourceClient dataSourceClient = [[DataSourceClient alloc] init];
[dataSourceClient setFeed_key:@"YOUR_FEED_API_KEY"];
```

**Create Blueprint:**

```objc
NSDictionary *blueprint = @{ @"name": @"Sample Blueprint",
                      @"description": @"Longer description for Sample Blueprint",
                       @"visibility": @"public" };

[dataSourceClient createBlueprint:bp success:^(id object) {
    /*blueprint created*/
    NSDictionary *blueprintCreated = object;
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"%@",message);
    NSLog(@"%@",error);
}];
```

**List Data Sources from a Batch:**

```objc
[dataSourceClient listDataSourcesfromBatch:@"batch_id" success:^(id object) {
    [dataSources removeAllObjects];
    [dataSources addObjectsFromArray:[dataSourcesList objectForKey:@"datasources"]];
    [tableViewDataSources reloadData];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Add Data Source to an existing Batch:**

```objc
NSDictionary *serial = @{ @"serial": @"your_new_serial" };
//Add Data Source to the Batch
[dataSourceClient addDataSourceToBatch:@"batch_id" withParameters:serial success:^(id object) {
    //data source successfully added.
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Create Batch:**

```objc
NSDictionary *batch = @{ @"name": @"your_batch_name" ,
                  @"description": @"a_description",
                   @"visibility": @"private" };

[dataSourceClient createBatch:batch success:^(id object) {
    //batch successfully created.
    NSDictionary *batchCreated = object;
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**View Data Source Details:**

```objc
[dataSourceClient viewDetailsForDataSourceId:@"datasource_id" success:^(id object) {
    //set label with data source info.
    [lblDSName setText:[object valueForKey:@"name"]];
    [lblDSDescription setText:[object valueForKey:@"name"]];
    [lblDSSerial setText:[object valueForKey:@"serial"]];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Create Data Source:**

```objc
NSDictionary *datasource = @{ @"name": @"Sample Data Source",
                       @"description": @"Longer description for Sample Data Source",
                        @"visibility": @"public" };

[dataSourceClient createDataSource:datasource success:^(id object) {
    /*Data Source created*/
    NSDictionary *dataSourceCreated = object;
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

#### [KeysClient](/lib/DataSourceClient.h) ([Spec](https://m2x.att.com/developer/documentation/keys))

```objc
KeysClient keyClient = [[KeysClient alloc] init];
[keyClient setFeed_key:@"YOUR_FEED_API_KEY"];
```

**List Keys:**

```objc
[keysClient listKeysWithParameters:nil success:^(id object) {
    [keysArray removeAllObjects];
    [keysArray addObjectsFromArray:[object objectForKey:@"keys"]];
    [self.tableView reloadData];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**View Key Details:**

```objc
[keysClient viewDetailsForKey:_key success:^(id object) {
    NSString *name = [object valueForKey:@"name"];
    NSString *key = [object valueForKey:@"key"];
    NSString *expiresAt = [object valueForKey:@"expires_at"];
    NSString *permissions = [[object objectForKey:@"permissions"] componentsJoinedByString:@", "];

    [lblName setText:name];
    [lblKey setText:key];
    [lblPermissions setText:permissions];
    //check if expires_at isn't set.
    if(![expiresAt isEqual:[NSNull null]]){
        [lblExpiresAt setText:expiresAt];
    }
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Regenerate Key:**

```objc
[keysClient regenerateKey:_key success:^(id object) {
    //Update key label
    [lblKey setText:[object valueForKey:@"key"]];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

#### Errors and Messages

The errors and messages are handled in the failure block. The *error* parameter is a `NSError` object that encapsulate the error information, for example the HTTP status code. And the *message* parameter is a `NSDictionary` and contains the response message from the API.

To get the HTTP status code from *error* use the method `- localizedDescription`.

## Demo App

This repository comes with a simple app that implements some of the API methods. It can be found in the following folder: `M2X_iOS`.



## License

The iOS M2X API Client is available under the MIT license. See the LICENSE file for more information.
