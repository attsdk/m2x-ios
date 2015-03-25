# AT&T's M2X iOS Client

[AT&T M2X](http://m2x.att.com) is a cloud-based fully managed time-series data storage service for network connected machine-to-machine (M2M) devices and the Internet of Things (IoT). 

The [AT&T M2X API](https://m2x.att.com/developer/documentation/overview) provides all the needed operations and methods to connect your devices to AT&T's M2X service. This library aims to provide a simple wrapper to interact with the AT&T M2X API for [iOS](https://www.apple.com/ios/). Refer to the [Glossary of Terms](https://m2x.att.com/developer/documentation/glossary) to understand the nomenclature used throughout this documentation.

Getting Started
==========================
1. Signup for an [M2X Account](https://m2x.att.com/signup).
2. Obtain your _Master Key_ from the Master Keys tab of your [Account Settings](https://m2x.att.com/account) screen.
2. Create your first [Device](https://m2x.att.com/devices) and copy its _Device ID_.
3. Review the [M2X API Documentation](https://m2x.att.com/developer/documentation/overview).

## Installation

Copy the content from the `lib` folder to your project or add `M2XLib/M2XLib.xcodeproj` as a subproject. In the last case, make sure to set the `Other Linker Flags` build setting to **-ObjC**.

The M2X iOS Client is compatible with the **iOS 7 SDK** (or above). The HomeKit demo app will only work with Xcode 6, the **iOS 8.0 SDK**, and a compatible HomeKit device or with the HomeKit Accessory Simulator.

## Usage

In order to communicate with the M2X API, you need an instance of [M2XClient](lib/M2XClient.m). You need to pass your API key in the initializer to access your data.

```objc
M2XClient *m2x = [[M2XClient alloc] initWithApiKey:@"<YOUR-API-KEY>"]
```

This provides an interface to your data on M2X

- [Distribution](lib/M2XDistribution.m)
  ```objc
    [m2x distributionsWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        ...
    }];

    [m2x distributionWithId:@"<DISTRIBUTION-ID>" completionHandler:^(M2XDistribution *distribution, M2XResponse *response) {
        ...
    }];
```

- [Device](lib/M2XDevice.m)
  ```objc
    [m2x devicesWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        ...
    }];

    [m2x deviceWithId:@"<DEVICE-ID>" completionHandler:^(M2XDevice *device, M2XResponse *response) {
        ...
    }];
```

- [Key](lib/M2XKey.m)
  ```objc
    [m2x keysWithCompletionHandler:^(NSArray *objects, M2XResponse *response) {
        ...
    }];

    [m2x keyWithKey:@"<KEY-ID>" completionHandler:^(M2XKey *key, M2XResponse *response) {
        ...
    }];  
```

Refer to the documentation on each class for further usage instructions.

## Example

Open [M2X_iOS project](M2X_iOS/M2X_iOS.xcodeproj) to see different scenarios on how to use the library.

## HomeKit Demo App

The lib includes a [demo app](HomeKitDemo/HomeKitDemo.xcodeproj) demonstrating integration possibilities between the iOS 8 HomeKit framework and M2X. To build the demo app you'll need Xcode 6 and a HomeKit-compatible thermostat. You could also simulate the thermostat using the HomeKit Accessory Simulator, available in the Hardware IO Tools.

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

## Versioning

This lib aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). As a summary, given a version number `MAJOR.MINOR.PATCH`:

1. `MAJOR` will increment when backwards-incompatible changes are introduced to the client.
2. `MINOR` will increment when backwards-compatible functionality is added.
3. `PATCH` will increment with backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the `MAJOR.MINOR.PATCH` format.

**Note**: the client version does not necessarily reflect the version used in the AT&T M2X API.


## Community Demo Applications
Members of the community have also built open source sample applications that utilize the M2X iOS client that could prove useful:

* Healthy Baby: https://github.com/citrusbyte/Healthy-Baby

*<small>Please note that AT&T M2X provides links to the above unofficial Community Demos for your convenience. AT&T is not responsible for, and expressly disclaims all liability for, and damages of any kind arising out of use of or reliance on these Community Demos. Links from AT&T M2X to third-party sites do not constitute an endorsement by AT&T of the parties or their products and services.</small>*


## License

This lib is provided under the MIT license. See [LICENSE](LICENSE) for applicable terms.
