//
//  WorkoutDetailViewController.h
//  do-you-even-lift
//
//  Created by Daniel Ayeni on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "AddExercisesMidWorkout.h"
#import "WorkoutPlan.h"
#import "CompletedWorkout.h"
#import <CoreMotion/CoreMotion.h>



@interface WorkoutDetailViewController : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate, AddExercisesMidWorkout>

@property (strong,nonatomic) WorkoutPlan *workoutPlan;
@property (strong,nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutPlanNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) CMPedometer *pedometer;
@property (nonatomic,retain) NSArray *exercises;
@property (nonatomic) BOOL newWorkout;

-(IBAction)finishButtonPressed:(id)sender;
-(NSArray*)getUnselectedExercises;









@end
