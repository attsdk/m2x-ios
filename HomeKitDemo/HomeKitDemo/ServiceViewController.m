//
//  ServiceViewController.m
//  HomeKitDemo
//

//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "ServiceViewController.h"
#import "M2X.h"

@interface ServiceViewController ()

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) HMCharacteristic *selectedCharacteristic;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) M2XStream *stream;
@property (nonatomic, strong) NSString *M2XDevice;
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
    self.M2XDevice = config[@"device"];
    self.M2XStream = config[@"stream"];
    
    M2XClient *client = [[M2XClient alloc] initWithApiKey:M2XKey];
    M2XDevice *device = [[M2XDevice alloc] initWithClient:client attributes:@{@"id": self.M2XDevice}];
    _stream = [[M2XStream alloc] initWithClient:client device:device attributes:@{@"name": self.M2XStream}];
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
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)saveValuesToM2X:(id)sender
{
    NSMutableArray *valuesToSave = self.values;
    self.values = [NSMutableArray new];
    [self.tableView reloadData];
    
    [_stream postValues:valuesToSave completionHandler:^(M2XResponse *response) {
        if (response.error) {
            NSLog(@"Warning! Failed to post values to M2X (%@)", response.errorObject.localizedDescription);
            return;
        }
        
        NSString *text = [NSString stringWithFormat:@"M2X: Successfully posted %lu values to the M2X stream!", (unsigned long)valuesToSave.count];
        [[[UIAlertView alloc] initWithTitle:@"Success!"
                                    message:text
                                   delegate:nil cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];

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
