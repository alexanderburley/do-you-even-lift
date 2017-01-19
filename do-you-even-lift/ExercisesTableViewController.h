//
//  ExercisesTableViewController.h
//  do-you-even-lift
//
//  Created by Alex Burley on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UIColor+AppColors.h"
#import "WorkoutDetailViewController.h"

@interface ExercisesTableViewController : UITableViewController

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) WorkoutDetailViewController *midWorkoutDelegate;

- (IBAction)addExercise:(id)sender;

@end
