//
//  M2XMetadata.h
//  M2X_iOS
//
//  Created by Luis Floreani on 12/28/15.
//  Copyright (c) 2015 citrusbyte.com. All rights reserved.
//

@protocol M2XMetadata
// Read an object's metadata
//
// https://m2x.att.com/developer/documentation/v2/device#Read-Device-Metadata
// https://m2x.att.com/developer/documentation/v2/distribution#Read-Distribution-Metadata
// https://m2x.att.com/developer/documentation/v2/collections#Read-Collection-Metadata
- (void)metadataWithCompletionHandler:(M2XBaseCallback)completionHandler;

// Read a single field of an object's metadata
//
// https://m2x.att.com/developer/documentation/v2/device#Read-Device-Metadata-Field
// https://m2x.att.com/developer/documentation/v2/distribution#Read-Distribution-Metadata-Field
// https://m2x.att.com/developer/documentation/v2/collections#Read-Collection-Metadata-Field
- (void)metadataField:(NSString *)field completionHandler:(M2XBaseCallback)completionHandler;

// Update an object's metadata
//
// https://m2x.att.com/developer/documentation/v2/device#Update-Device-Metadata
// https://m2x.att.com/developer/documentation/v2/distribution#Update-Distribution-Metadata
// https://m2x.att.com/developer/documentation/v2/collections#Update-Collection-Metadata
- (void)updateMetadata:(NSDictionary *)data completionHandler:(M2XResourceCallback)completionHandler;

// Update a single field of an object's metadata
//
// https://m2x.att.com/developer/documentation/v2/device#Update-Device-Metadata-Field
// https://m2x.att.com/developer/documentation/v2/distribution#Update-Distribution-Metadata-Field
// https://m2x.att.com/developer/documentation/v2/collections#Update-Collection-Metadata-Field
- (void)updateMetadataField:(NSString *)field value:(id)value completionHandler:(M2XResourceCallback)completionHandler;
@end