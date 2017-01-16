//
//  WorkoutDetailViewController.h
//  do-you-even-lift
//
//  Created by Daniel Ayeni on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "WorkoutPlan.h"
#import "CompletedWorkout.h"


@interface WorkoutDetailViewController : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) WorkoutPlan *workoutPlan;
@property (strong,nonatomic) NSTimer *timer;
//@property (strong,nonatomic) NSInteger *steps;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;



-(void)timerFired:(NSTimer *)timer;
-(void)cancelFinish;
-(void)finishWorkout;

-(IBAction)startTimer:(id)sender;
-(IBAction)finishWorkoutButtonPressed:(id)sender;









@end
