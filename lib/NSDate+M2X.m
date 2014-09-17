//
//  NSDate+M2X.m
//  M2X_iOS
//
//  Copyright (c) 2014 AT&T. All rights reserved.
//

#import "NSDate+M2X.h"

@implementation NSDate (M2X)

- (NSString *) toISO8601
{
    NSDateFormatter *df = [NSDateFormatter new];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    df.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    return [df stringFromDate:self];
}

+ (NSDate *) fromISO8601:(NSString *)dateString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return [df dateFromString:dateString];
}

@end
