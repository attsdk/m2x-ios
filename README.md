# AT&T's M2X iOS Client

[AT&T’s M2X](https://m2x.att.com/) is a cloud-based fully managed data storage service for network connected machine-to-machine (M2M) devices. From trucks and turbines to vending machines and freight containers, M2X enables the devices that power your business to connect and share valuable data.

This library aims to provide a simple wrapper to interact with [AT&T M2X API](https://m2x.att.com/developer/documentation/overview). Refer to the [Glossary of Terms](https://m2x.att.com/developer/documentation/glossary) to understand the nomenclature used through this documentation.


Getting Started
==========================
1. Signup for an [M2X Account](https://m2x.att.com/signup).
2. Obtain your _Master Key_ from the Master Keys tab of your [Account Settings](https://m2x.att.com/account) screen.
2. Create your first [Device](https://m2x.att.com/devices) and copy its _Device ID_.
3. Review the [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

## Installation

Copy the content from the `lib` folder to your project or add `M2XLib/M2XLib.xcodeproj` as a subproject.

The M2X iOS Client is compatible with the **iOS 7 SDK** (or above). The HomeKit demo app will only work with Xcode 6, the **iOS 8.0 SDK**, and a compatible HomeKit device or with the HomeKit Accessory Simulator.

## Usage

CBBM2x is the main class that provides the methods to set the API URL ("http://api-m2x.att.com/v2" as default) and the Master Key.

**Example:**

```objc
//get singleton instance of M2x Class
CBBM2x* m2x = [CBBM2x shared];
//set the Master Api Key
m2x.apiKey = @"your_api_key";
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
[client listDevicesWithParameters:nil completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    if (!error) {
        NSDictionary *response = object[@"devices"];
        NSMutableArray *deviceList = [NSMutableArray array];
        for (NSDictionary *device in response) {
            //show only active devices
            if([[device valueForKey:@"status"] isEqualToString:@"enabled"])
                [deviceList addObject:device];
        }
    } else {
        NSLog(@"Error: %@",[error description]);
    }
}];
```

**View Device Details:**

```objc
[client viewDetailsForDeviceId:@"device_id" completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    if (!error) {
        [lblDSName setText:[object valueForKey:@"name"]];
        [lblDSDescription setText:[object valueForKey:@"name"]];
        [lblDSSerial setText:[object valueForKey:@"serial"]];
    } else {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
}];
```

**Create Device:**

```objc
NSDictionary *device = @{ @"name": @"Sample Device",
                       @"description": @"Longer description for Sample Device",
                        @"visibility": @"public" };

[client createDevice:device completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    if (!error) {
        NSDictionary *deviceCreated = object;
    } else {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
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

[client updateDeviceWithLocation:locationDict inDevice:@"your_device_id" completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    if (!error) {
        [self didSetLocation];
    } else {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
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

[client createTrigger:trigger inDevice:@"ee9501931bcb3f9b0d25fde5eaf4abd8" completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    ...
}];
```

**View Request Log**

```objc
[client viewRequestLogForDevice:@"YOUR_DEVICE_ID" completionHandler:^(id object, NSURLResponse *response, NSError *error) {
...
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
                     completionHandler:^(id object, NSURLResponse *response, NSError *error) {
                     ... 
                     }
];
```

#### [CBBDistributionClient](/lib/CBBDistributionClient.h) ([Spec](https://m2x.att.com/developer/documentation/device))


```objc
CBBDistributionClient *client = [[CBBDistributionClient alloc] init];
[deviceClient setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**List Devices from a Distribution:**

```objc
[client listDevicesFromDistribution:@"distribution_id" completionHandler:^(id object, NSURLResponse *response, NSError *error) {
...
}];
```

**Add Device to an existing Distribution:**

```objc
NSDictionary *serial = @{ @"serial": @"your_new_serial" };
//Add Device to the Distribution
[client addDeviceToDistribution:@"distribution_id" withParameters:serial completionHandler:^(id object, NSURLResponse *response, NSError *error) {
...
}];
```

**Create Distribution:**

```objc
NSDictionary *distribution = @{ @"name": @"your_distribution_name" ,
                  @"description": @"a_description",
                   @"visibility": @"private" };

[client createDistribution:distribution completionHandler:^(id object, NSURLResponse *response, NSError *error) {
...
}];
```

#### [CBBKeysClient](/lib/CBBKeysClient.h) ([Spec](https://m2x.att.com/developer/documentation/keys))

```objc
CBBKeysClient *client = [[CBBKeysClient alloc] init];
[client setDeviceKey:@"YOUR_DEVICE_API_KEY"];
```

**List Keys:**

```objc
[client listKeysWithParameters:nil completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    if (!error) {
      NSArray *keys = object[@"keys"];
    }
}];
```

**View Key Details:**

```objc
[client viewDetailsForKey:_key completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    NSString *name = [object valueForKey:@"name"];
    NSString *key = [object valueForKey:@"key"];
    NSString *expiresAt = [object valueForKey:@"expires_at"];
    NSString *permissions = [object[@"permissions"] componentsJoinedByString:@", "];

    [lblName setText:name];
    [lblKey setText:key];
    [lblPermissions setText:permissions];
    //check if expires_at isn't set.
    if(![expiresAt isEqual:[NSNull null]]){
        [lblExpiresAt setText:expiresAt];
    }
}];
```

**Regenerate Key:**

```objc
[client regenerateKey:_key completionHandler:^(id object, NSURLResponse *response, NSError *error) {
    //Update key label
    [lblKey setText:[object valueForKey:@"key"]];
}];
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

#### Errors and Messages

The *error* parameter is a `NSError` object that encapsulate the error information, check for its domain and code.

To get the HTTP status code use the `response` object

## Demos

### HomeKit Demo App

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

### Demo App

This repository comes with a simple app that implements some of the API methods. It can be found in the following folder: `M2X_iOS`.

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). As a summary, given a version number `MAJOR.MINOR.PATCH`:

1. `MAJOR` will increment when backwards-incompatible changes are introduced to the client.
2. `MINOR` will increment when backwards-compatible functionality is added.
3. `PATCH` will increment with backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the `MAJOR.MINOR.PATCH` format.

**Note**: the client version does not necessarily reflect the version used in the AT&T M2X API.

## License

This library is provided under the MIT license. See [LICENSE](LICENSE) for applicable terms.
