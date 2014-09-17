//
//  ServiceViewController.h
//  HomeKitDemo
//
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface ServiceViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, strong) HMAccessory *accessory;
@property (nonatomic, strong) HMService *service;

@end
