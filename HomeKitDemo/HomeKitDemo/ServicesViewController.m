//
//  ServicesViewController.m
//  HomeKitDemo
//

//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "ServicesViewController.h"
#import "ServiceViewController.h"

@interface ServicesViewController ()

@end

@implementation ServicesViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"Services of %@", self.accessory.name];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToService"])
    {
        ServiceViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.accessory = self.accessory;
        vc.service = self.accessory.services[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accessory.services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    HMService *service = self.accessory.services[indexPath.row];
    cell.textLabel.text = service.name;
    return cell;
}


@end
