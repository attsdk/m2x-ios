#iOS M2X API Client

The AT&T [M2X API](https://m2x.att.com/developer/documentation/overview) provides all the needed operations to connect your devices to AT&T's M2X service. This client provides an easy to use interface for your favorite mobile platform, iOS.

## Getting Started

- Signup for an M2X Account: [https://m2x.att.com/signup](https://m2x.att.com/signup)
- Obtain your Master Key from the Master Keys tab of your Account Settings: [https://m2x.att.com/account](https://m2x.att.com/account)
- Create your first Data Source Blueprint and copy its Feed ID: [https://m2x.att.com/blueprints](https://m2x.att.com/blueprints)
- Review the M2X API Documentation: [https://m2x.att.com/developer/documentation/overview](https://m2x.att.com/developer/documentation/overview)

If you have questions about any M2X specific terms, please consult the M2X glossary: https://m2x.att.com/developer/documentation/glossary

##Installation

Copy the content from the `lib` folder to your project. 

Note: The `lib` folder contains the AFNetworking library to make the HTTP requests.

## Requirements and Dependencies

The M2X iOS Client was developed in **iOS SDK 7.0**.

The client has the following library dependency:

* AFNetworking, 2.0, [https://github.com/AFNetworking/AFNetworking](https://github.com/AFNetworking/AFNetworking)

## Architecture

Currently, the client supports M2X API v1. All M2X API specifications can be found at [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

### M2X Class

M2X is the main class that provides the methods to set the API Url ("https://api-m2x.att.com/v1" as default) and the Master Key.

**Example:**

```objc

//get singleton instance of M2x Class
M2x* m2x = [M2x shared];
//set the Master Api Key
m2x.api_key = @"your_api_key";
//set the api url
m2x.api_url = @"your_api_url"; // https://api-m2x.att.com/v1 as default
```

The method `-iSO8601ToDate:` parse from a ISO8601 Date `NSString` to `NSDate`:

```objc

-(NSDate*)iSO8601ToDate:(NSString*)dateString;
```

### FeedClient Class

The FeedClient class provides the interface to make all the Feeds request on the API.
If the call requires parameters, it must be encapsulated in a `NSDictionary` following the respective estructure from the [Feed API Documentation](https://m2x.att.com/developer/documentation/feed).

As well as the parameters, the response returns in a `NSDictionary` object. 

If required, a [Feed API key](https://m2x.att.com/developer/documentation/overview#API-Keys) can be set in this class.

```objc
	FeedsClient *_feedClient = [[FeedsClient alloc] init];
	[_feedClient setFeed_key:@"YOUR_FEED_API_KEY"];
```

####Examples:

**Adding the feed list to a `NSMutableArray` all Feeds:**

```objc

//retrieve a list of feeds without parameters
[_feedClient listWithParameters:nil success:^(id object) {
    NSDictionary *response = [value objectForKey:@"feeds"];
	feedList = [NSMutableArray array];
	//add elements to the list
	for (id feed in response) {
		[feedList addObject:feed];
	}
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"%@",[error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
                                @"elevation": [NSString stringWithFormat:@"%f",location.altitude]};

[_feedClient updateDatasourceWithLocation:locationDict inFeed:_feed_id success:^(id object) {
	//Callback function
    [self didSetLocation];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}];
    
```

**Post Data Stream Values:**

```objc
NSDictionary *newValue = @{ @"values": @[
                   @{ @"value": [_tfNewValue text] } ] };
        
[_feedClient postDataValues:newValue forStream:_streamName inFeed:_feed_id success:^(id object) {
    //success block
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}];
```

### BlueprintClient Class

[Coming Soon].

### KeysClient

[Coming Soon].

## License

The iOS M2X API Client is available under the MIT license. See the LICENSE file for more info.
