//
//  CompletedWorkoutExercise+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by Alex Burley on 22/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompletedWorkoutExercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompletedWorkoutExercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *completed;
@property (nullable, nonatomic, retain) CompletedWorkout *completed_workout;
@property (nullable, nonatomic, retain) Exercise *exercise;

@end

NS_ASSUME_NONNULL_END
