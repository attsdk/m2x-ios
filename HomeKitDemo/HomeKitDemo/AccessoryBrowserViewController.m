//
//  AccessoryBrowserViewController.m
//  HomeKitDemo
//
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
    
    NSLog(@"Looking for new accessories");
    self.accesoryBrowser = [HMAccessoryBrowser new];
    self.accesoryBrowser.delegate = self;
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
    NSLog(@"Found accessory: %@", accessory);
    [self.accessories addObject:accessory];
    NSSortDescriptor *byName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sorted = [self.accessories sortedArrayUsingDescriptors:@[byName]];
    self.accessories = [NSMutableArray arrayWithArray:sorted];
    [self.tableView reloadData];
}

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{
    NSLog(@"Lost contact with accessory: %@", accessory);
    [self.accessories removeObject:accessory];
    [self.tableView reloadData];
}

@end
