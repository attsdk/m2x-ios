//
//  AccessoryBrowserViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "AccessoryBrowserViewController.h"

@interface AccessoryBrowserViewController ()

@property (nonatomic, strong) HMAccessoryBrowser *accesoryBrowser;
@property (nonatomic, strong) NSMutableArray *accessories;

@end

@implementation AccessoryBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.accessories = [NSMutableArray new];
    self.accesoryBrowser = [HMAccessoryBrowser new];
    [self.accesoryBrowser startSearchingForNewAccessories];
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accessories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    HMAccessory *accessory = self.accessories[indexPath.row];
    cell.textLabel.text = accessory.name;
    return cell;
}

#pragma mark - UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMAccessory *accessory = self.accessories[indexPath.row];
    [self.delegate didUserPickAccessory:accessory];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HMAccessoryBrowserDelegate protocol

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{
    [self.accessories addObject:accessory];
    NSSortDescriptor *byName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sorted = [self.accessories sortedArrayUsingDescriptors:@[byName]];
    self.accessories = [NSMutableArray arrayWithArray:sorted];
    [self.tableView reloadData];
}

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{
    [self.accessories removeObject:accessory];
    [self.tableView reloadData];
}

@end
