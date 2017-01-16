//
//  FinishedWorkoutViewController.h
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutDetailViewController.h"
#import "WorkoutPlan.h"


@interface FinishedWorkoutViewController : UIViewController

@property (strong,nonatomic) NSNumber *timeTaken;
@property (weak,nonatomic) WorkoutPlan *workoutPlan;
@property (weak,nonatomic) WorkoutDetailViewController *delegate;

- (IBAction)saveWorkoutButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
