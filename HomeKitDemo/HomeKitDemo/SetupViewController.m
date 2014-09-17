//
//  SetupViewController.m
//  HomeKitDemo
//

//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *key;
@property (weak, nonatomic) IBOutlet UITextField *feed;
@property (weak, nonatomic) IBOutlet UITextField *stream;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *config = [defs objectForKey:@"M2X_CONFIG"];
    self.key.text = config[@"key"];
    self.feed.text = config[@"feed"];
    self.stream.text = config[@"stream"];   
    [self.key becomeFirstResponder];
    
    [[[UIAlertView alloc] initWithTitle:@"M2X+HomeKit demo app"
                                message:
      @"This app retrieves data values from "
      @"HomeKit-compatible thermostats and uploads them to M2X. "
      @"In order to proceed, make sure the HomeKit Accessory Simulator "
      @"is running and configure test accessories"
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
    
}

- (IBAction)saveConfig:(id)sender
{
    if ([self.key.text isEqualToString:@""] ||
        [self.feed.text isEqualToString:@""] ||
        [self.stream.text isEqualToString:@""] )
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                   message:@"Please enter a valid M2X key, feed ID and stream name"
                                  delegate:nil
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil] show];
        
    } else {
        NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
        [defs setObject:@{
                          @"key": self.key.text,
                          @"feed": self.feed.text,
                          @"stream": self.stream.text
                          }
                 forKey:@"M2X_CONFIG"];
        [defs synchronize];
        [self performSegueWithIdentifier:@"ToHomes" sender:self];
    }
    
}

@end
