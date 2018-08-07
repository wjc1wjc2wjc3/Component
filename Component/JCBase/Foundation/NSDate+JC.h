//
//  NSDate+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JC)

+ (NSDate *)convertDateFromString:(NSString*)srcDate;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDateMin:(NSDate *)date;
+ (NSString *)stringFromDateSecond:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromStringDay:(NSString *)dateString;
+ (NSMutableArray *)littleEndian:(NSInteger)date;
+ (NSDate *)dateCurrentDayEnd:(NSDate *)date;

@end
