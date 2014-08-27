//
//  HomesViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 8/25/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "HomesViewController.h"

@interface HomesViewController ()

@property (nonatomic, strong) HMHomeManager *homeManager;

@end

@implementation HomesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.homeManager = [HMHomeManager new];
    self.homeManager.delegate = self;
}

- (void)createHomeWithName:(NSString *)homeName
{
    [self.homeManager addHomeWithName:homeName
                    completionHandler:^(HMHome *home, NSError *error)
    {
        if (error) {
            NSLog(@"Failed to create home: %@", error.description);
            [[[UIAlertView alloc] initWithTitle:@""
                                        message:@"Could not create home"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

#pragma mark - IBActions

- (IBAction)addNewHome:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Home"
                                                        message:@"Enter Home Name"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.delegate = self;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeManager.homes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    HMHome *home = self.homeManager.homes[indexPath.row];
    cell.textLabel.text = home.name;
    return cell;
}

#pragma mark - UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        [self createHomeWithName:nameField.text];
    }
}

#pragma mark - HMHomeManagerDelegate protocol

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self.tableView reloadData];
}

@end
