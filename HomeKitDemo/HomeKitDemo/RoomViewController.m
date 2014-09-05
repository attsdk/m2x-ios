//
//  RoomViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/4/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "RoomViewController.h"

@interface RoomViewController ()

@end

@implementation RoomViewController

- (void)setRoom:(HMRoom *)room
{
    _room = room;
    self.title = room.name;
}

- (IBAction)addAccessory:(id)sender
{
    
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.room.accessories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    HMAccessory *accessory = self.room.accessories[indexPath.row];
    cell.textLabel.text = accessory.name;
    return cell;
}

@end
