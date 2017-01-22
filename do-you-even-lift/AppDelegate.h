//
//  AppDelegate.h
//  do-you-even-lift
//
//  Created by Alex Burley on 07/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NSDate+CreateDate.h"
#import "CompletedWorkoutExercise.h"
#import "CompletedWorkout.h"
#import "Exercise.h"
#import "WorkoutPlan.h"
#import "WorkoutPlanExercise.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

