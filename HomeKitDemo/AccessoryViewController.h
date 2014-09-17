//
//  AccessoryViewController.h
//  HomeKitDemo
//
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface AccessoryViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) HMHome *home;
@property (nonatomic, strong) HMAccessory *accessory;

@end
