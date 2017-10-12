//
//  NSDate+Utils.h
//  BloodSugar
//
//  Created by PeterPan on 16-01-08.
//  Copyright (c) 2013年 shake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (Utils)
//转成date
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

// 相差几天
+ (NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

- (NSInteger)dayCountInMonth; // 一个月有几天

+ (NSDate *)dateWithHour:(int)hour
                  minute:(int)minute;

#pragma mark - Getter
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSString *)weekday;


#pragma mark - Time string

// (YES,YES == am上午09:56) (NO,NO == 09:56) (YES,NO == 上午09:56) (NO,YES == am 09:56)
- (NSString *)timeHourMinute;
- (NSString *)timeHourMinuteWithPrefix;
- (NSString *)timeHourMinuteWithSuffix;
- (NSString *)timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix;

#pragma mark - Date String
- (NSString *)stringTime;  // 时间 10:04
- (NSString *)stringMonthDay; // 07月05日
- (NSString *)stringYearMonthDay; //2017-07-05
- (NSString *)stringYearMonthDayHourMinuteSecond;  // 2017-07-05 10:07:09
+ (NSString *)stringYearMonthDayWithDate:(NSDate *)date;      //date转是当前年月日字符串
+ (NSString *)stringLoacalDate;    // 当前时间字符串
- (NSString *)string;              //时间转字符串
- (NSString *)stringCutSeconds;    //转字符串去掉秒

#pragma mark - Date formate
+ (NSString *)dateFormatString; 
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)timestampFormatStringSubSeconds;

#pragma mark - Date adjust

- (NSDate *)offsetMonth:(int)tmp;  // 月份滚动:-1上月,+1下月
- (NSDate *)offsetDay:(int)tmp;  // 天滚动:-1前一天,+1后一天

#pragma mark - Relative dates from the date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days; //几天之后
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days; // 几天之前
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours; // 几小时之后
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours; // 几小时之前
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes; // 几分钟之后
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes; // 几分钟之前


#pragma mark - Date compare
- (BOOL)isEqualToDateIgnoringTime: (NSDate *) aDate;   // 两个时间是否相同

+ (NSDate *)dateWithString:(NSString *)dateString;  //  字符串转NSDate

+ (NSDate *)timestampConvertToDate:(NSString *)timestamp; //时间戳转时间

- (NSString *)dateConvertToTimestamp; //日期转时间错

- (NSString *)showCustomTime;  // 上午 10:30
@end
