//
//  CompletedWorkoutViewController.h
//  do-you-even-lift
//
//  Created by Alex Burley on 22/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompletedWorkout.h"
#import <CoreData/CoreData.h>
#import "UIColor+AppColors.h"
#import "QuartzCore/QuartzCore.h"
#import "CompletedWorkoutExercise.h"
#import "Exercise.h"
#import "WorkoutPlan.h"
#import "AppDelegate.h"

@interface CompletedWorkoutViewController : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate>


@property(weak, nonatomic) NSString *action;
@property(weak, nonatomic) CompletedWorkout *completedWorkout;
@property (weak, nonatomic) IBOutlet UILabel *workoutName;
@property (weak, nonatomic) IBOutlet UITableView *exerciseCompleted;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *stepsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCompletedLabel;
@property (weak, nonatomic) IBOutlet UIButton *savePlanButton;
- (IBAction)savePlanButtonPressed:(id)sender;

@end
