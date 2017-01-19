//
//  AppDelegate.m
//  do-you-even-lift
//
//  Created by Alex Burley on 07/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSUserDefaults *userDefaults;
    int launchCount;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    launchCount = [userDefaults integerForKey:@"launchCount"] + 1;
    [userDefaults setInteger:launchCount forKey:@"launchCount"];
    [userDefaults synchronize];
    
    if (launchCount == 1){
        
        
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = app.managedObjectContext;
        
        NSManagedObject *biCurls= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [biCurls setValue:@"Bicep Curls" forKey:@"exercise_name"];
        [biCurls setValue:@"Arms" forKey:@"muscle_group"];
        NSManagedObject *hCurls= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [hCurls setValue:@"Hammer Curls" forKey:@"exercise_name"];
        [hCurls setValue:@"Arms" forKey:@"muscle_group"];
        NSManagedObject *textension= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [textension setValue:@"Tricep Extension" forKey:@"exercise_name"];
        [textension setValue:@"Arms" forKey:@"muscle_group"];
        
        NSArray *armExercises = [[NSArray alloc] initWithObjects:biCurls,hCurls,textension, nil];
        
        NSManagedObject *squats= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [squats setValue:@"Squats" forKey:@"exercise_name"];
        [squats setValue:@"Legs" forKey:@"muscle_group"];
        NSManagedObject *lunges= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [lunges setValue:@"Lunges" forKey:@"exercise_name"];
        [lunges setValue:@"Legs" forKey:@"muscle_group"];
        NSManagedObject *lcurls= [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [lcurls setValue:@"Leg Curls" forKey:@"exercise_name"];
        [lcurls setValue:@"Legs" forKey:@"muscle_group"];
        
        NSArray *legExercises = [[NSArray alloc] initWithObjects:squats,lunges,lcurls, nil];
        
        NSManagedObject *arms = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlan" inManagedObjectContext:context];
        [arms setValue:@"Arm Day" forKey:@"plan_name"];
        NSManagedObject *legs = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlan" inManagedObjectContext:context];
        [legs setValue:@"Intense Legs" forKey:@"plan_name"];
        
        
        for (id exercise in armExercises){
            NSManagedObject *newWorkoutPlanExercise = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlanExercise" inManagedObjectContext:context];
            [newWorkoutPlanExercise setValue:exercise forKey:@"exercise"];
            [newWorkoutPlanExercise setValue:arms forKey:@"workout_plan"];
        }
        for (id exercise in legExercises){
            NSManagedObject *newWorkoutPlanExercise = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlanExercise" inManagedObjectContext:context];
            [newWorkoutPlanExercise setValue:exercise forKey:@"exercise"];
            [newWorkoutPlanExercise setValue:legs forKey:@"workout_plan"];
        }
        
        NSManagedObject *janWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorkout" inManagedObjectContext:context];
        [janWorkout setValue:[NSDate dateWithYear:2016 month:3 day:20] forKey:@"date_completed"];
        [janWorkout setValue:[NSNumber numberWithInteger:676] forKey:@"time_taken"];
        [janWorkout setValue:arms forKey:@"workout_plan"];
        
        NSManagedObject *mayWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorkout" inManagedObjectContext:context];
        [mayWorkout setValue:[NSDate dateWithYear:2017 month:5 day:15] forKey:@"date_completed"];
        [mayWorkout setValue:[NSNumber numberWithInteger:462] forKey:@"time_taken"];
        [mayWorkout setValue:legs forKey:@"workout_plan"];

        NSError *saveError = nil;
        if(![context save:&saveError]){
            NSLog(@"Unable to initalise data %@, %@", saveError, [saveError localizedDescription]);
        }
        else {
            NSLog(@"app initialised");
        }

    }
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if ([UIApplication instanceMethodForSelector:@selector(registerUserNotificationSettings:)]){
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge| UIUserNotificationTypeSound categories:nil]];
    }
    
    if (localNotification) {
        application.applicationIconBadgeNumber = 0;
    }
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


- (BOOL)application:(UIApplication *)application
                                            openURL:(NSURL *)url
                                                    sourceApplication:(NSString *)sourceApplication
                                                        annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification{
    application.applicationIconBadgeNumber = 0;
}





#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sheffield.do_you_even_lift" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"do_you_even_lift" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"do_you_even_lift.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
