//
//  AccessoryViewController.h
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface AccessoryViewController : UITableViewController

@property (nonatomic, strong) HMHome *home;
@property (nonatomic, strong) HMAccessory *accessory;

@end
