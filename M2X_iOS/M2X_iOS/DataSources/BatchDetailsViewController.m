//
//  BatchDetailsViewController.m
//  M2X_iOS
//
//  Created by Fernando Javier González on 12/16/13.
//  Copyright (c) 2013 AT&T. All rights reserved.
//

#import "BatchDetailsViewController.h"

@interface BatchDetailsViewController ()

@end

@implementation BatchDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _dataSources = [NSMutableArray array];
    
    _tableViewDataSources.dataSource = self;
    
    [self getBatchDescription];
    
    [self getDataSourcesForBatch];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

-(void)getBatchDescription{
    
    [_dataSourceClient viewDetailsForBatchId:_batch_id success:^(id object) {
        
        [self didGetBatchDescription:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        NSLog(@"%@",message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@", message]
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}

-(void)didGetBatchDescription:(NSDictionary*)batchDescription{
    
    [_lblBatchID setText:[batchDescription valueForKey:@"id"]];
    
    //format date
    NSDate *createdDate = [[M2x shared] iSO8601ToDate:[batchDescription valueForKey:@"created"]];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:createdDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [_lblCreatedAt setText:dateString];
    
}

-(void)getDataSourcesForBatch{
    
    [_dataSourceClient listDataSourcesfromBatch:_batch_id success:^(id object) {
        
        [self didGetDataSourcesForBatch:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        NSLog(@"%@",message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@", message]
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}

-(void)didGetDataSourcesForBatch:(NSDictionary*)dataSourcesList{
    
    [_dataSources removeAllObjects];
    
    NSDictionary *dataSourcesInDictionary = [dataSourcesList objectForKey:@"datasources"];
    
    for (id dataSource in dataSourcesInDictionary) {
        [_dataSources addObject:dataSource];
    }
    
    [_tableViewDataSources reloadData];
    
}

#pragma mark - Avoid Automatic Adjust

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dataSourceData = [_dataSources objectAtIndex:indexPath.row];
    
    UIImage *status_img;
    
    if([[dataSourceData valueForKey:@"status"]isEqualToString:@"enabled"])
        status_img = [UIImage imageNamed:@"green.png"];
    else
        status_img = [UIImage imageNamed:@"red.png"];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:status_img];
    
    [[cell textLabel] setText:[dataSourceData valueForKey:@"name"]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"serial: %@",[dataSourceData valueForKey:@"serial"]]];
    
    return cell;
}

@end
