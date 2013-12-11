#iOS M2X API Client

The AT&T [M2X API](https://m2x.att.com/developer/documentation/overview) provides all the needed operations to connect your devices to AT&T's M2X service. This client provides an easy to use interface for your favorite language, Objective-C.

## How To Get Started

- Signup for an M2X Account: [https://m2x.att.com/signup](https://m2x.att.com/signup)
- Obtain your Master Key from the Master Keys tab of your Account Settings: [https://m2x.att.com/account](https://m2x.att.com/account)
- Create your first Data Source Blueprint and copy its Feed ID: [https://m2x.att.com/blueprints](https://m2x.att.com/blueprints)
- Review the M2X API Documentation: [https://m2x.att.com/developer/documentation/overview](https://m2x.att.com/developer/documentation/overview)

If you have questions about any M2X specific terms, please consult the M2X glossary: https://m2x.att.com/developer/documentation/glossary

##Installation

Copy the content of the `lib` folder in your project. 

Note: The `lib` folder contains the AFNetworking library to make the HTTP requests.

## Requirements and Dependencies

The M2X iOS Client was developed in iOS SDK 7.0.

The client has the following library dependency:

* AFNetworking, 2.0, [https://github.com/AFNetworking/AFNetworking](https://github.com/AFNetworking/AFNetworking)

## Architecture

Currently, the client supports API v1 and all M2X API documents can be found at [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

### M2X Class

M2X is the main class that provides the methods to set the API Url ("https://api-m2x.att.com/v1" is default) and the Master Key.

Example:
```objc
	//get the singleton instance
	M2x* m2x = [M2x shared];
    //set the Master Api Key
    m2x.api_key = @"your_api_key";
    //set the api url
    m2x.api_url = @"your_api_url"; // https://api-m2x.att.com/v1 as default
```

### FeedClient Class

The FeedClient class provides the interface to make all the Feeds request on the api.
If the call requires parameters, they have to be encapsulated in a `NSDictionary` following the respective estructure from the [Feed API Documentation](https://m2x.att.com/developer/documentation/feed).

As well as the parameters, the response came all in a `NSDictionary` object. 

If required a [Feed API key](https://m2x.att.com/developer/documentation/overview#API-Keys), it can be set in this class.

```objc

	FeedsClient *_feedClient = [[FeedsClient alloc] init];
	[_feedClient setFeed_key:@"YOUR_FEED_API_KEY"];
```

####Examples:

**Adding the feed list to a `NSMutableArray` all Feeds:**

```objc

	//retrieve the list of feeds without parameters
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

### BlueprintClient Class

[Coming Soon].

### KeysClient

[Coming Soon].

## License

iOS M2X API Client is available under the MIT license. See the LICENSE file for more info.
