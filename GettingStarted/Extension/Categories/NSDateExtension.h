//
//  NSDateExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2/17/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateExtension : NSObject

@end

#pragma mark - Utilities

@interface NSDate (CHXUtilities)

// Relative dates from the current date
+ (NSDate *)chx_dateTomorrow;
+ (NSDate *)chx_dateYesterday;
+ (NSDate *)chx_dateWithDaysFromNow:(NSUInteger)days;
+ (NSDate *)chx_dateWithDaysBeforeNow:(NSUInteger)days;
+ (NSDate *)chx_dateWithHoursFormNow:(NSUInteger)dHours;
+ (NSDate *)chx_dateWithHoursBeforeNow:(NSUInteger)dHours;
+ (NSDate *)chx_dateWithMinutesFromNow:(NSUInteger)dMinutes;
+ (NSDate *)chx_dateWithMinutesBeforeNow:(NSUInteger)dMinutes;

// Comparing dates
- (BOOL)chx_isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)chx_isToday;
- (BOOL)chx_isTomorrow;
- (BOOL)chx_isYesterday;
- (BOOL)chx_isSameWeekAsDate:(NSDate *)date;
- (BOOL)chx_isThisWeek;
- (BOOL)chx_isNextWeek;
- (BOOL)chx_isLastWeek;
- (BOOL)chx_isSameMonthAsDate:(NSDate *)date;
- (BOOL)chx_isThisMonth;
- (BOOL)chx_isSameYearAsDate:(NSDate *)date;
- (BOOL)chx_isThisYear;
- (BOOL)chx_isNextYear;
- (BOOL)chx_isLastYear;
- (BOOL)chx_isEarlierThanDate:(NSDate *)date;
- (BOOL)chx_isLaterThanDate:(NSDate *)date;

// Date roles
- (BOOL)chx_rsTypicallyWorkday;
- (BOOL)chx_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)chx_dateByAddingDays:(NSInteger)days;
- (NSDate *)chx_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)chx_dateByAddingHours:(NSInteger)hours;
- (NSDate *)chx_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)chx_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)chx_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)chx_dateAtStartOfDay;

// Retrieving intervals
- (NSUInteger)chx_minutesAfterDate:(NSDate *)date;
- (NSUInteger)chx_minutesBeforeDate:(NSDate *)date;
- (NSUInteger)chx_hoursAfterDate:(NSDate *)date;
- (NSUInteger)chx_hoursBeforeDate:(NSDate *)date;
- (NSUInteger)chx_daysAfterDate:(NSDate *)date;
- (NSUInteger)chx_daysBeforeDate:(NSDate *)date;

// Decomposing dates
- (NSUInteger)chx_nearestHour;
- (NSUInteger)chx_hour;
- (NSUInteger)chx_minute;
- (NSUInteger)chx_seconds;
- (NSUInteger)chx_day;
- (NSUInteger)chx_month;
- (NSUInteger)chx_week;
- (NSUInteger)chx_weekday;
- (NSUInteger)chx_nthWeekday;
- (NSUInteger)chx_year;

@end