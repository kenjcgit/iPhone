//
//  NSDate+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;
- (NSString*)ranDomString;

+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;
- (NSString *)timeAgoInWords;
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;

- (NSString *)briefTimeAgoInWords;
+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;
/* @pending */
+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second timeZone:(NSTimeZone *)timeZone;

+ (NSCalendar *)gregorianCalendar;

- (NSCalendar *)gregorianCalendar;

- (int)year;
- (int)month;
- (int)hour;
- (int)day;
- (int)minute;
- (int)second;


- (NSDate *)beginningOfDay;
@end
