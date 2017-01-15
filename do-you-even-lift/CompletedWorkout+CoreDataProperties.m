//
//  CompletedWorkout+CoreDataProperties.m
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompletedWorkout+CoreDataProperties.h"

@implementation CompletedWorkout (CoreDataProperties)

@dynamic date_completed;
@dynamic steps;
@dynamic time_taken;
@dynamic workout_plan;

@end
