//
//  Exercise+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Exercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *exercise_name;
@property (nullable, nonatomic, retain) NSString *muscle_group;
@property (nullable, nonatomic, retain) PersonalBest *pb;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *workout_plan_exercise;

@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addWorkout_plan_exerciseObject:(NSManagedObject *)value;
- (void)removeWorkout_plan_exerciseObject:(NSManagedObject *)value;
- (void)addWorkout_plan_exercise:(NSSet<NSManagedObject *> *)values;
- (void)removeWorkout_plan_exercise:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
