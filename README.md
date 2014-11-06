# iOS M2X API Client

The AT&T [M2X API](https://m2x.att.com/developer/documentation/overview) provides all the needed operations to connect your devices to AT&T's M2X service. This client provides an easy to use interface for your favorite mobile platform, [iOS](https://developer.apple.com/programs/ios/).

## Getting Started

- Signup for an M2X Account: [https://m2x.att.com/signup](https://m2x.att.com/signup)
- Obtain your Master Key from the Master Keys tab of your Account Settings: [https://m2x.att.com/account](https://m2x.att.com/account)
- Create your first Device and copy its Device ID: [https://m2x.att.com/blueprints](https://m2x.att.com/devices)
- Review the M2X API Documentation: [https://m2x.att.com/developer/documentation/overview](https://m2x.att.com/developer/documentation/overview)

If you have questions about any M2X specific terms, please consult the M2X glossary: https://m2x.att.com/developer/documentation/glossary

##Installation

Copy the content from the `lib` folder to your project or add `M2XLib/M2XLib.xcodeproj` as a subproject.

## Requirements and Dependencies

The M2X iOS Client is compatible with the **iOS 7 SDK** (or above). The HomeKit demo app will only work with Xcode 6, the **iOS 8.0 SDK**, and a compatible HomeKit device or with the HomeKit Accessory Simulator.

## HomeKit Demo App

The SDK includes a demo app demonstrating integration possibilities between the iOS 8 HomeKit framework and M2X. To build the demo app you'll need Xcode 6 and a HomeKit-compatible thermostat. You could also simulate the thermostat using the HomeKit Accessory Simulator, available in the Hardware IO Tools.

The HomeKit Demo App is capable of monitoring a thermostat's current temperature characteristic, capture temperature values and post them to M2X simply by tapping a button.

After running the Demo App for the first time, you will have to:

* Provide a Device ID for testing purposes
* Provide a valid stream name belonging to the previously defined Device
* Finally, enter a valid M2X key with enough POST permissions. Using the Master Key is possible but not required.

If you haven't done it before you will have setup your home and accessories.

* Create a Home by tapping the + button and assign a name for it.
* Select the Home, tap the + button and select "Create New Room". Enter a name for the new room, then tap OK.
* Find a new accessory: tap the + button and select "Find New Accessory". This will display the Accessory Browser. At this point you should turn on your HomeKit-compatible device or open the HomeKit Accessory Simulator. Your accessory should appear on the list. When it does, select it and follow the indications on screen.
* Tap on the accessory name and assign it to the newly created room.

Finally, in order to view and post data you simply need to:

* Tap on the room name, then the accessory name and finally on the service name. This should start displaying a new current temperature value every 1 second.
* Tap the Save button to post all currently available data points to M2X. Old data will be automatically removed from the table.

## Architecture

Currently, the client supports M2X API v2. All M2X API specifications can be found in the [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

For API v1, check branch 'v1.0' (deprecated)

### M2X Class

M2X is the main class that provides the methods to set the API URL ("http://api-m2x.att.com/v2" as default) and the Master Key.

**Example:**

```objc
//get singleton instance of M2x Class
CBBM2x* m2x = [CBBM2x shared];
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
NSDate *distributionCreationDate = [NSDate fromISO8601:distribution[@"created"]];
```

### API Clients
---
The clients (`CBBDeviceClient`, `CBBStreamClient`, `CBBDistributionClient` and `CBBKeysClient`) provide an interface to make all the requests on the respectives API.

If the call requires parameters, it must be encapsulated in a `NSDictionary` following the respective estructure from the [API Documentation](https://m2x.att.com/developer/documentation/overview).
As well as the parameters, the response is returned in a `NSDictionary` object.

If required, a [Device API key](https://m2x.att.com/developer/documentation/overview#API-Keys) can be set in these classes.

#### [CBBDeviceClient](/lib/CBBDeviceClient.h) ([Spec](https://m2x.att.com/developer/documentation/device))

```objc
CBBDeviceClient *client = [[CBBDeviceClient alloc] init];
[client setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**List Devices in a `NSMutableArray`:**

```objc

// Note that for this call you need your Master API Key,
// otherwise you'll get a 401 Unauthorized error.
[client setDeviceKey:@"YOUR_MASTER_API_KEY"];

//retrieve a list of devices without parameters
[client listDevicesWithParameters:nil success:^(id object) {

  NSDictionary *response = [value objectForKey:@"devices"];
  deviceList = [NSMutableArray array];
  for (NSDictionary *device in response) {
      //show only active devices
      if([[device valueForKey:@"status"] isEqualToString:@"enabled"])
          [deviceList addObject:device];
  }

} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error description]);
    NSLog(@"Message: %@",message);
}];
```

**View Device Details:**

```objc
[client viewDetailsForDeviceId:@"device_id" success:^(id object) {
    //set label with device info.
    [lblDSName setText:[object valueForKey:@"name"]];
    [lblDSDescription setText:[object valueForKey:@"name"]];
    [lblDSSerial setText:[object valueForKey:@"serial"]];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Create Device:**

```objc
NSDictionary *device = @{ @"name": @"Sample Device",
                       @"description": @"Longer description for Sample Device",
                        @"visibility": @"public" };

[client createDevice:device success:^(id object) {
    /*Device created*/
    NSDictionary *deviceCreated = object;
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
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

[client updateDeviceWithLocation:locationDict inDevice:@"your_device_id" success:^(id object) {
	//Callback function
    [self didSetLocation];
} failure:^(NSError *error, NSDictionary *message) {
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

[client createTrigger:trigger inDevice:@"ee9501931bcb3f9b0d25fde5eaf4abd8" success:^(id object) {
    /*success block*/
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**View Request Log**

```objc
[client viewRequestLogForDevice:@"YOUR_DEVICE_ID" success:^(id object) {
  NSArray *requests = [object objectForKey:@"requests"];
} failure:^(NSError *error, NSDictionary *message) {
  NSLog(@"error: %@",[error localizedDescription]);
  NSLog(@"Message: %@",message);
}];
```

#### [CBBStreamClient](/lib/CBBStreamClient.h) ([Spec](https://m2x.att.com/developer/documentation/stream))


```objc
CBBStreamClient *client = [[CBBStreamClient alloc] init];
[deviceClient setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**Post Data Stream Values:**

```objc
NSString *now = [NSDate date].toISO8601;
NSDictionary *newValue = @{ @"values": @[ @{ @"value": @"20", @"timestamp": now } ] };

[client postDataValues:newValue
                  forStream:@"stream_name"
                     inDevice:@"your_device_id"
                     success:^(id object) { /*success block*/ }
                     failure:^(NSError *error, NSDictionary *message)
{
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

#### [CBBDistributionClient](/lib/CBBDistributionClient.h) ([Spec](https://m2x.att.com/developer/documentation/device))


```objc
CBBDistributionClient *client = [[CBBDistributionClient alloc] init];
[deviceClient setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**List Devices from a Distribution:**

```objc
[client listDevicesfromDistribution:@"distribution_id" success:^(id object) {
    [devices removeAllObjects];
    [devices addObjectsFromArray:[devicesList objectForKey:@"devices"]];
    [tableViewDevices reloadData];
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Add Device to an existing Distribution:**

```objc
NSDictionary *serial = @{ @"serial": @"your_new_serial" };
//Add Device to the Distribution
[client addDeviceToDistribution:@"distribution_id" withParameters:serial success:^(id object) {
    //Device successfully added.
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

**Create Distribution:**

```objc
NSDictionary *distribution = @{ @"name": @"your_distribution_name" ,
                  @"description": @"a_description",
                   @"visibility": @"private" };

[client createDistribution:distribution success:^(id object) {
    //distribution successfully created.
    NSDictionary *distributionCreated = object;
} failure:^(NSError *error, NSDictionary *message) {
    NSLog(@"Error: %@",[error localizedDescription]);
    NSLog(@"Message: %@",message);
}];
```

#### [CBBKeysClient](/lib/CBBKeysClient.h) ([Spec](https://m2x.att.com/developer/documentation/keys))

```objc
CBBKeysClient *client = [[CBBKeysClient alloc] init];
[client setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**List Keys:**

```objc
[client listKeysWithParameters:nil success:^(id object) {
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
[client viewDetailsForKey:_key success:^(id object) {
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
[client regenerateKey:_key success:^(id object) {
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

The iOS M2X API Client is available under the MIT license. See the [LICENSE](LICENSE) file for more information.
