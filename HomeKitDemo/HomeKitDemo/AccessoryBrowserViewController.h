//
//  AccessoryBrowserViewController.h
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@protocol AccessoryBrowserDelegate <NSObject>
- (void)didUserPickAccessory:(HMAccessory *)accessory;
@end

@interface AccessoryBrowserViewController : UITableViewController <HMAccessoryBrowserDelegate> 

@property (nonatomic, weak) id <AccessoryBrowserDelegate> delegate;

@end
