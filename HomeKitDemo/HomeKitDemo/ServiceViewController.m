//
//  ServiceViewController.m
//  HomeKitDemo
//
//  Created by Leandro Tami on 9/5/14.
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "ServiceViewController.h"
#import "M2x.h"
#import "FeedsClient.h"

@interface ServiceViewController ()

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) HMCharacteristic *selectedCharacteristic;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) FeedsClient *feedClient;
@property (nonatomic, strong) NSString *M2XFeed;
@property (nonatomic, strong) NSString *M2XStream;

@end

@implementation ServiceViewController

- (void)viewDidLoad
{
    self.values = [NSMutableArray new];
    self.title = [NSString stringWithFormat:@"Temperature of %@", self.service.name];

    [self setUpM2X];
    [self validateService];
}

- (void)dealloc
{
    [self.timer invalidate];
}

- (void)setUpM2X
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *config = [defs objectForKey:@"M2X_CONFIG"];
    NSString *M2XKey = config[@"key"];
    self.M2XFeed = config[@"feed"];
    self.M2XStream = config[@"stream"];
    
    [M2x shared].api_key = M2XKey;
    self.feedClient = [FeedsClient new];
}

- (void)validateService
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"characteristicType like %@", HMCharacteristicTypeCurrentTemperature];
    NSArray *filteredArray = [self.service.characteristics filteredArrayUsingPredicate:predicate];
    if (filteredArray.count)
    {
        self.selectedCharacteristic = filteredArray[0];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(addDataPoint)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Current temperature not available"
                                    message:@"The demo app requires a service that provides the \"current temperature\" characteristic."
                                   delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

- (void)addDataPoint
{
    NSString *now = [NSDate date].toISO8601;
    [self.selectedCharacteristic readValueWithCompletionHandler:^(NSError *error)
    {
        if (!error) {
            NSNumber *value = self.selectedCharacteristic.value;
            NSDictionary *item = @{ @"at": now,
                                    @"value": value };
            [self.values insertObject:item atIndex:0];
            [self postToM2X:value withTimestamp:now];
            [self.tableView reloadData];
        }
    }];
}

- (void)postToM2X:(NSNumber *)value
    withTimestamp:(NSString *)timestamp
{
    
}

- (IBAction)saveValuesToM2X:(id)sender
{
    NSMutableArray *valuesToSave = self.values;
    self.values = [NSMutableArray new];
    [self.tableView reloadData];
    
    [self.feedClient postDataValues:@{ @"values": valuesToSave }
                          forStream:self.M2XStream
                             inFeed:self.M2XFeed
                            success:^(id object)
     {
         NSString *text = [NSString stringWithFormat:@"M2X: Successfully posted %lu values to the M2X stream!", (unsigned long)valuesToSave.count];
         [[[UIAlertView alloc] initWithTitle:@"Success!"
                                     message:text
                                    delegate:nil cancelButtonTitle:@"Ok"
                           otherButtonTitles:nil] show];
     }
                            failure:^(NSError *error, NSDictionary *message)
     {
         NSLog(@"Warning! Failed to post values to M2X (%@)", error.localizedDescription);
     }];
    
}

#pragma mark - UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    NSDictionary *item = self.values[indexPath.row];
    cell.textLabel.text = item[@"at"];
    NSNumber *value = item[@"value"];
    NSString *valueString = [NSString stringWithFormat:@"%.2f", value.floatValue];
    cell.detailTextLabel.text = valueString;
    return cell;
}

@end
