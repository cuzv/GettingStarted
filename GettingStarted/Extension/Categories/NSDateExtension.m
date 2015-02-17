//
//  NSDateExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2/17/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import "NSDateExtension.h"

@implementation NSDateExtension

@end


#pragma mark - Utilities

#define kMinute 60
#define kHour 3600
#define kDay 86400
#define kWeek 604800
#define kYear 31556926

#define DATE_COMPONENTS (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | \
                        NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | \
                        NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

@implementation NSDate (CHXUtilities)

// Relative dates from the current date

+ (NSDate *)chx_dateTomorrow {
    return [NSDate chx_dateWithDaysFromNow:1];
}

+ (NSDate *)chx_dateYesterday {
    return [NSDate chx_dateWithDaysBeforeNow:1];
}

+ (NSDate *)chx_dateWithDaysFromNow:(NSUInteger)days {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)chx_dateWithDaysBeforeNow:(NSUInteger)days {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)chx_dateWithHoursFormNow:(NSUInteger)dHours {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kHour * dHours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)chx_dateWithHoursBeforeNow:(NSUInteger)dHours {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kHour * dHours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)chx_dateWithMinutesFromNow:(NSUInteger)dMinutes {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kMinute * dMinutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)chx_dateWithMinutesBeforeNow:(NSUInteger)dMinutes {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kMinute * dMinutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}



// Comparing dates
- (BOOL)chx_isEqualToDateIgnoringTime:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:date];
    return ((components.year == anotherComponents.year) &&
            (components.month == anotherComponents.month) &&
            (components.day == anotherComponents.day));
}

- (BOOL)chx_isToday {
    return [self chx_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)chx_isTomorrow {
    return [self chx_isEqualToDateIgnoringTime:[NSDate chx_dateTomorrow]];
}

- (BOOL)chx_isYesterday {
    return [self chx_isEqualToDateIgnoringTime:[NSDate chx_dateYesterday]];
}

- (BOOL)chx_isSameWeekAsDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:date];

    if (components.weekday != anotherComponents.weekday) {
        return NO;
    }

    return (abs([self timeIntervalSinceDate:date]) < kWeek);
}

- (BOOL)chx_isThisWeek {
   return [self chx_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)chx_isNextWeek {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kWeek;
    return [self chx_isSameWeekAsDate:[NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval]];
}

- (BOOL)chx_isLastWeek {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kWeek;
    return [self chx_isSameWeekAsDate:[NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval]];
}

- (BOOL)chx_isSameMonthAsDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];

    return ((components.month == anotherComponents.month) &&
            (components.year == anotherComponents.year));
}

- (BOOL)chx_isThisMonth {
    return [self chx_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)chx_isSameYearAsDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];

    return (components.year == anotherComponents.year);
}

- (BOOL)chx_isThisYear {
    return [self chx_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)chx_isNextYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return components.year == (anotherComponents.year + 1);
}

- (BOOL)chx_isLastYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *anotherComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return components.year == (anotherComponents.year - 1);
}

- (BOOL)chx_isEarlierThanDate:(NSDate *)date {
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)chx_isLaterThanDate:(NSDate *)date {
    return [self compare:date] == NSOrderedDescending;
}

// Date roles
- (BOOL)chx_rsTypicallyWorkday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    if (components.weekday == 1 || components.weekday == 7) {
        return YES;
    }
    return NO;
}

- (BOOL)chx_isTypicallyWeekend {
    return ![self chx_isTypicallyWeekend];
}

// Adjusting dates
- (NSDate *)chx_dateByAddingDays:(NSInteger)days {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

- (NSDate *)chx_dateBySubtractingDays:(NSInteger)days {
    return [self chx_dateByAddingDays:(days * -1)];
}

- (NSDate *)chx_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

- (NSDate *)chx_dateBySubtractingHours:(NSInteger)hours {
    return [self chx_dateByAddingHours:(hours * -1)];
}

- (NSDate *)chx_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kMinute * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

- (NSDate *)chx_dateBySubtractingMinutes:(NSInteger)minutes {
    return [self chx_dateByAddingMinutes:(minutes * -1)];
}

- (NSDate *)chx_dateAtStartOfDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDateComponents *)chx_componentsWithOffsetFromDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:date toDate:self options:0];
}

// Retrieving intervals
- (NSUInteger)chx_minutesAfterDate:(NSDate *)date {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];
    return (NSUInteger) (timeInterval / kMinute);
}

- (NSUInteger)chx_minutesBeforeDate:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:self];
    return (NSUInteger) (timeInterval / kMinute);
}

- (NSUInteger)chx_hoursAfterDate:(NSDate *)date {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];
    return (NSUInteger) (timeInterval / kHour);
}

- (NSUInteger)chx_hoursBeforeDate:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:self];
    return (NSUInteger) (timeInterval / kHour);
}

- (NSUInteger)chx_daysAfterDate:(NSDate *)date {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];
    return (NSUInteger) (timeInterval / kDay);
}

- (NSUInteger)chx_daysBeforeDate:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:self];
    return (NSUInteger) (timeInterval / kDay);
}

// Decomposing dates
- (NSUInteger)chx_nearestHour {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kMinute * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSUInteger)chx_hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSUInteger)chx_minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSUInteger)chx_seconds {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSUInteger)chx_day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSUInteger)chx_month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSUInteger)chx_week {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.weekOfMonth;
}

- (NSUInteger)chx_weekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSUInteger)chx_nthWeekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSUInteger)chx_year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    return components.year;
}
@end

