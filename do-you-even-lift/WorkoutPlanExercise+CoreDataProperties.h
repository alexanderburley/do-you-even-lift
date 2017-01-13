//
//  WorkoutPlanExercise+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutPlanExercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutPlanExercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *reps;
@property (nullable, nonatomic, retain) NSNumber *sets;
@property (nullable, nonatomic, retain) Exercise *exercise;
@property (nullable, nonatomic, retain) WorkoutPlan *workout_plan;

@end

NS_ASSUME_NONNULL_END
