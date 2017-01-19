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

/*

@dynamic primitiveDateCompleted, primitiveSectionIdentifier;

// Insert code here to add functionality to your managed object subclass

- (NSString*)section_identifier{
    
    // Create and cache the section identifier on demand.
    
    [self willAccessValueForKey:@"section_identifier"];
    NSString *tmp = [self primitiveSectionIdentifier];
    [self didAccessValueForKey:@"section_identifier"];
    
    
    if (!tmp)
    {
        /*
         Sections are organized by month and year. Create the section identifier as a string representing the number (year * 1000) + month; this way they will be correctly ordered chronologically regardless of the actual name of the month.
 
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[self date_completed]];
        tmp = [NSString stringWithFormat:@"%d", ([components year] * 1000) + [components month]];
        [self setPrimitiveSectionIdentifier:tmp];
    }
    return tmp;

}

#pragma mark - Date Completed

- (void)setDate_completed:(NSDate *)date_completed
{
    // If the date_completed changes, the section identifier become invalid.
    [self willChangeValueForKey:@"date_completed"];
    [self setPrimitiveDateCompleted:date_completed];
    [self didChangeValueForKey:@"date_completed"];
    
    [self setPrimitiveSectionIdentifier:nil];
}

-(void)setPrimitiveDateCompleted:(NSDate *)primitiveDateCompleted{
    self.primitiveDateCompleted = primitiveDateCompleted;
}


#pragma mark - Key path dependencies

+ (NSSet *)keyPathsForValuesAffectingSectionIdentifier
{
    // If the value of date_completed changes, the section identifier may change as well.
    return [NSSet setWithObject:@"date_completed"];
}
*/

@end
