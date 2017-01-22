//
//  CompletedWorkout.m
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//


/*
 
 Reference code used was DateSectionTitles provided by Apple
 */

#import "CompletedWorkout.h"
#import "WorkoutPlan.h"

@interface CompletedWorkout ()

//@property (nonatomic) NSDate *primitiveDateCompleted;
//@property (nonatomic) NSString *primitiveSectionIdentifier;

@end

@implementation CompletedWorkout

-(NSString*)section_identifier{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[self date_completed]];
    return [NSDateFormatter localizedStringFromDate:self.date_completed
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterNoStyle];

}



@end
