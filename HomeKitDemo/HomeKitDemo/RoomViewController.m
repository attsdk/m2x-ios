//
//  RoomViewController.m
//  HomeKitDemo
//

//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "RoomViewController.h"
#import "ServicesViewController.h"

@interface RoomViewController ()

@end

@implementation RoomViewController

- (void)setRoom:(HMRoom *)room
{
    _room = room;
    self.title = room.name;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToValues"])
    {
        ServicesViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HMAccessory *accessory = self.room.accessories[indexPath.row];
        vc.accessory = accessory;
    }
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
