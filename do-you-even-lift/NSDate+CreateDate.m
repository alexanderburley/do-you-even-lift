//
//  NSDate+CreateDate.m
//  do-you-even-lift
//
//  Created by aca13ab on 19/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "NSDate+CreateDate.h"

@implementation NSDate (CreateDate)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

@end
