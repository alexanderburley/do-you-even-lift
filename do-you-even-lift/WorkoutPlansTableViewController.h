//
//  WorkoutsViewController.h
//  do-you-even-lift
//
//  Created by aca13ab on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface WorkoutPlansTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addWorkoutPlan:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEditPlanButton;

@end
