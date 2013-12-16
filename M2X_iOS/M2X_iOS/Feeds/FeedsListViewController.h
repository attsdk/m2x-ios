//
//  FeedsListViewController.h
//  M2X_iOS
//
//  Created by Fernando Javier González on 12/6/13.
//  Copyright (c) 2013 AT&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "FeedsClient.h"

@interface FeedsListViewController : UITableViewController {
    
}
@property (strong, nonatomic) NSString *masterKey;
@property (strong, nonatomic) NSString *feedKey;
@property (strong, nonatomic) FeedsClient *feedClient;

@property (nonatomic, retain) NSMutableArray *data;



@end
