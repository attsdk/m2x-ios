//
//  AccessoryViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "AccessoryViewController.h"


@interface AccessoryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation AccessoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setAccessory:(HMAccessory *)accessory
{
    _accessory = accessory;
    self.title = accessory.name;
}

@end
