//
//  NSDate+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "NSDate+SSToolkitAdditions.h"
#include <time.h>

@implementation NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
	if (!string) {
		return nil;
	}
	
	struct tm tm;
	strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
//	tm.tm_isdst = -1;
	time_t t = mktime(&tm);
	
	return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

- (NSString*)ranDomString
{
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y%m%d%H%M%S", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
	
}
- (NSString *)ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%S.%s%z", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

//	Adapted from http://github.com/gabriel/gh-kit/blob/master/Classes/GHNSString+TimeInterval.m
+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
	
	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		if (!includeSeconds) {
			return intervalInMinutes <= 0 ? @"less than a minute" : @"1 minute";
		}
		if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
			return [NSString stringWithFormat:@"%d seconds ago", 5];
		} else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
			return [NSString stringWithFormat:@"%d seconds ago", 10];
		} else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
			return [NSString stringWithFormat:@"%d seconds ago", 20];
		} else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
			return @"half a minute";
		} else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
			return @"less than a minute";
	 	} else {
			return @"1 minute";
		}		
	} else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
		return [NSString stringWithFormat:@"%.0f minutes ago", intervalInMinutes];
	} else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
		return @"1 hour";
	} else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
		return [NSString stringWithFormat:@"%.0f hours ago", round(intervalInMinutes / 60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return @"1 day";
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:@"%.0f days ago", round(intervalInMinutes / 1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return @"1 month";
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:@"%.0f months ago", round(intervalInMinutes / 43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return @"1 year";
	} else {
		return [NSString stringWithFormat:@"%.0f years ago", round(intervalInMinutes / 525600.0f)];
	}
	return nil;
}


- (NSString *)briefTimeAgoInWords {
	NSTimeInterval intervalInSeconds = fabs([self timeIntervalSinceNow]);
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
	
	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		return @"1 min";		
	} else if (intervalInMinutes >= 2 && intervalInMinutes < 60) {
		return [NSString stringWithFormat:@"%.0f mins ago", intervalInMinutes];
	} else if (intervalInMinutes >= 60 && intervalInMinutes < 61) {
		return @"1 hour";
	} else if (intervalInMinutes > 60 && intervalInMinutes < 1440) {
		return [NSString stringWithFormat:@"%.0f hours ago", round(intervalInMinutes/60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return @"1 day";
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:@"%.0f days ago", round(intervalInMinutes/1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return @"1 month";
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:@"%.0f months ago", round(intervalInMinutes/43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return @"1 year";
	} else {
		return [NSString stringWithFormat:@"%.0f years ago", round(intervalInMinutes/525600.0f)];
	}
	return nil;
}


- (NSString *)timeAgoInWords {
	return [self timeAgoInWordsIncludingSeconds:YES];
}


- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds {
	return [[self class] timeAgoInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];		
}

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second
{
    return [self dateWithYear:year month:month day:day hour:hour minute:minute second:second timeZone:[NSTimeZone localTimeZone]];
}

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second timeZone:(NSTimeZone *)timeZone
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSCalendar *gregorian = [self gregorianCalendar];
    [gregorian setTimeZone:timeZone];
    return [gregorian dateFromComponents:components];
}

+ (NSCalendar *)gregorianCalendar
{
    return [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
}

- (NSCalendar *)gregorianCalendar
{
    return [[self class] gregorianCalendar];
}

- (int)year
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (int)month
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (int)day
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (int)hour
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (int)minute
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}

- (int)second
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}

- (NSDate *)beginningOfDay
{
    return [NSDate dateWithYear:[self year] month:[self month] day:[self day] hour:0 minute:0 second:0];
}

@end
