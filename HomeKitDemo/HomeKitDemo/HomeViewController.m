//
//  HomeViewController.m
//  HomeKitDemo
//

//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "HomeViewController.h"
#import "RoomViewController.h"
#import "AccessoryViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToRoom"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RoomViewController *vc = segue.destinationViewController;
        vc.room = self.home.rooms[indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"ToAccessory"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AccessoryViewController *vc = segue.destinationViewController;
        vc.accessory = self.home.accessories[indexPath.row];
        vc.home = self.home;
    }
    else if ([segue.identifier isEqualToString:@"ToAccessoryBrowser"])
    {
        AccessoryBrowserViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

- (void)setHome:(HMHome *)home
{
    _home = home;
    self.title = home.name;
}

- (void)createNewRoom
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Room"
                                                        message:@"Enter Room Name"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.delegate = self;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

#pragma mark - IBActions

- (IBAction)addItem:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Item"
                                                        message:@"What would you like to do?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Create New Room", @"Find New Accessory", nil];
    alertView.delegate = self;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"New Item"]) {
        
        if (buttonIndex == 1) {
            [self createNewRoom];
        } else if (buttonIndex == 2) {
            [self performSegueWithIdentifier:@"ToAccessoryBrowser" sender:self];
        }
        
    } else if ([alertView.title isEqualToString:@"New Room"]) {

        if (buttonIndex)
        {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            __weak HomeViewController *me = self;
            [self.home addRoomWithName:nameField.text
                     completionHandler:^(HMRoom *room, NSError *error) {
                         if (error) {
                             NSLog(@"Failed to create room: %@", error.description);
                             [[[UIAlertView alloc] initWithTitle:@""
                                                         message:@"Could not create room"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil] show];
                         } else {
                             NSLog(@"Room '%@' created successfully", room.name);
                             [me.tableView reloadData];
                         }
                     }];
            
        }

    }
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (!section) ? self.home.rooms.count : self.home.accessories.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (!section) ? @"Rooms" : @"Accessories";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell"
                                                                forIndexPath:indexPath];
        HMRoom *room = self.home.rooms[indexPath.row];
        cell.textLabel.text = room.name;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoryCell"
                                                                forIndexPath:indexPath];
        HMAccessory *accessory = self.home.accessories[indexPath.row];
        cell.textLabel.text = accessory.name;
        return cell;
    }
}

#pragma mark - AccessoryBrowserDelegate protocol

- (void)didUserPickAccessory:(HMAccessory *)accessory
{
    __weak HomeViewController *me = self;
    [self.home addAccessory:accessory
          completionHandler:^(NSError *error)
    {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Failed to add accessory"
                                        message:error.description
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Accessory Added"
                                        message:[NSString stringWithFormat:@"You have added the '%@' accessory to %@", accessory.name, me.home.name]
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }
    }];
}

@end
