//
//  RoomViewController.h
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/4/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface RoomViewController : UITableViewController

@property (nonatomic, strong) HMRoom *room;

@end
