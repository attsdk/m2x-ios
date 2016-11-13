//
//  M2XCommand.h
//  M2X_iOS
//
//  Created by ATT SDK.
//  Copyright © 2016 AT&T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2XResource.h"

@interface M2XCommand : M2XResource

// List Sent Commands: Retrieve the list of recent commands
//
// https://m2x.att.com/developer/documentation/v2/commands#List-Sent-Commands
- (void)listSentCommands:(M2XArrayCallback)completionHandler;

// Send Command: Send a command to the given target devices
//
// https://m2x.att.com/developer/documentation/v2/commands#Send-Command
- (void)sendCommand:(NSDictionary *)parameters completionHandler:(M2XBaseCallback)completionHandler;

// View Command Details: Get details of a sent command
//
// https://m2x.att.com/developer/documentation/v2/commands#View-Command-Details
- (void)viewCommandDetails:(NSString *)identifier completionHandler:(M2XBaseCallback)completionHandler;

@end
