//
//  FinishedWorkoutViewController.m
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "FinishedWorkoutViewController.h"
#import "CoreData/CoreData.h"
#import "AppDelegate.h"

@interface FinishedWorkoutViewController ()

@end

@implementation FinishedWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveWorkoutButtonPressed:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    
    NSManagedObject *newCompletedWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorkout" inManagedObjectContext:context];
    [newCompletedWorkout setValue:[NSDate date] forKey:@"date_completed"];
    [newCompletedWorkout setValue:self.timeTaken forKey:@"time_taken"];
    [newCompletedWorkout setValue:self.workoutPlan forKey:@"workout_plan"];
    //[newCompletedWorkout setValue:[self.steps] forKey:@"steps"];
    
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
                                                  
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate cancelFinish];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
