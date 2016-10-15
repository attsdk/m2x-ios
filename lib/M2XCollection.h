//
//  M2XCollection.h
//  M2XLib
//
//  Created by Luis Floreani on 12/29/15.
//  Copyright (c) 2015 citrusbyte.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2XResource.h"
#import "M2XMetadata.h"

@interface M2XCollection : M2XResource <M2XMetadata>

// Create a new collection
//
// https://m2x.att.com/developer/documentation/v2/collections#Create-Collection
+ (void)createWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XCollectionCallback)completionHandler;

// Retrieve the list of collections accessible by the authenticated API key
//
// https://m2x.att.com/developer/documentation/v2/collections#List-collections
+ (void)listWithClient:(M2XClient *)client parameters:(NSDictionary *)parameters completionHandler:(M2XArrayCallback)completionHandler;

// Add device to collection
//
//https://m2x.att.com/developer/documentation/v2/collections#Add-device-to-collection
+ (void)addDeviceToTheCollection:(M2XClient *)client withDeviceId:(NSString *)deviceid completionHandler:(M2XCollectionCallback)completionHandler;

// Remove device from collection
//
//https://m2x.att.com/developer/documentation/v2/collections#Remove-device-to-collection
+ (void)removeDeviceFromTheCollection:(M2XClient *)client withDeviceId:(NSString *)deviceid  completionHandler:(M2XCollectionCallback)completionHandler;

@end
