//
//  WorkoutPlan+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutPlan.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutPlan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *plan_name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *completed_workouts;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *workout_plan_exercise;

@end

@interface WorkoutPlan (CoreDataGeneratedAccessors)

- (void)addCompleted_workoutsObject:(NSManagedObject *)value;
- (void)removeCompleted_workoutsObject:(NSManagedObject *)value;
- (void)addCompleted_workouts:(NSSet<NSManagedObject *> *)values;
- (void)removeCompleted_workouts:(NSSet<NSManagedObject *> *)values;

- (void)addWorkout_plan_exerciseObject:(NSManagedObject *)value;
- (void)removeWorkout_plan_exerciseObject:(NSManagedObject *)value;
- (void)addWorkout_plan_exercise:(NSSet<NSManagedObject *> *)values;
- (void)removeWorkout_plan_exercise:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
