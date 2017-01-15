//
//  CompletedWorkout+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompletedWorkout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompletedWorkout (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date_completed;
@property (nullable, nonatomic, retain) NSNumber *steps;
@property (nullable, nonatomic, retain) NSNumber *time_taken;
@property (nullable, nonatomic, retain) WorkoutPlan *workout_plan;

@end

NS_ASSUME_NONNULL_END
