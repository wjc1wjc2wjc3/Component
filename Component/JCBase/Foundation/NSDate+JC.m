//
//  NSDate+JC.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "NSDate+JC.h"

@implementation NSDate (JC)

+ (NSDate *)dateCurrentDayEnd:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    NSDate *finalDate = [NSDate dateWithTimeIntervalSince1970:ts];
    return finalDate;
}

+ (NSDate *)convertDateFromString:(NSString*)srcDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:srcDate];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)stringFromDateMin:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)stringFromDateSecond:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

+ (NSDate *)dateFromStringDay:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (dateString.length == @"2018-01-01".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    }
    else if (dateString.length == @"2018-01-01 00:00".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    }
    else if (dateString.length == @"2018-01-01 00:00:00".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

@end
