//
//  WorkoutPlan.m
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "WorkoutPlan.h"

@implementation WorkoutPlan

-(NSString*)getName {
    return [self valueForKey:@"plan_name"];
}

-(NSArray*)getExercises {
    NSArray *exercises = [[[self valueForKey:@"workout_plan_exercise"] valueForKey:@"exercise"] allObjects];
    return [exercises[0] allObjects];
}

@end
