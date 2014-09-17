//
//  AccessoryViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "AccessoryViewController.h"


@interface AccessoryViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *roomPicker;
@property (assign, nonatomic) BOOL hasChangedRoom;
@end

@implementation AccessoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.title = self.accessory.name;
    if (self.accessory.room) {
        NSUInteger index = [self.home.rooms indexOfObject:self.accessory.room];
        if (index != NSNotFound) {
            [self.roomPicker selectRow:index+1
                           inComponent:0
                              animated:NO];            
        }
    }
    self.hasChangedRoom = NO;
}

- (IBAction)saveAccessoryInfo:(id)sender
{
    if (self.hasChangedRoom)
    {
        NSInteger row = [self.roomPicker selectedRowInComponent:0];
        
        HMRoom *room;
        if (row) {
            room = self.home.rooms[row-1];
        }
        
        __weak AccessoryViewController *me = self;
        [self.home assignAccessory:self.accessory
                            toRoom:room
                 completionHandler:^(NSError *error)
        {
            NSString *text;
            if (room.name) {
                text = [NSString stringWithFormat:@"%@ assigned to %@", self.accessory.name, room.name];
            } else {
                text = [NSString stringWithFormat:@"%@ is now unassigned", self.accessory.name];
            }
            
            [me dismissViewControllerAnimated:YES completion:nil];
            [[[UIAlertView alloc] initWithTitle:@""
                                        message:text
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }];
    }
}

#pragma mark - UIPickerViewDataSource protocol

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.home.rooms.count + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row) {
        HMRoom *room = self.home.rooms[row-1];
        return room.name;
    } else {
        return @"Not Assigned";
    }
}

#pragma mark - UIPickerViewDelegate protocol

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.hasChangedRoom = YES;
}

@end
