//
//  WorkoutsViewController.h
//  do-you-even-lift
//
//  Created by aca13ab on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface WorkoutPlansViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWorkoutPlan;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addWorkoutPlan:(id)sender;

@end
