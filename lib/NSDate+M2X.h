//
//  NSDate+M2X.h
//  M2X_iOS
//
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (M2X)

- (NSString *) toISO8601;
+ (NSDate *) fromISO8601:(NSString *)dateString;

@end
