//
//  WorkoutPlan.m
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "WorkoutPlan.h"

@implementation WorkoutPlan

// Insert code here to add functionality to your managed object subclass

-(NSArray*)getExercises {
    NSArray *exercises = [[self.workout_plan_exercise valueForKey:@"exercise"] allObjects];

    return exercises;
}

@end
