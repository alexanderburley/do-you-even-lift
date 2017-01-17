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
    int *min = [self.timeTaken intValue]/60;
    int *sec = [self.timeTaken intValue]%60;
    self.congratulationsLabel.numberOfLines = 0;
    self.congratulationsLabel.text = [NSString stringWithFormat:@"Congratulations! You completed your workout in %i minutes and %i seconds. During this workout you completed over XXX steps and completed XX exercises", min, sec];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
- (IBAction)returnWorkoutButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)discardWorkoutButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
