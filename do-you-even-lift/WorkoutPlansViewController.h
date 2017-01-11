//
//  WorkoutsViewController.h
//  do-you-even-lift
//
//  Created by aca13ab on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutPlansViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWorkoutPlan;

- (IBAction)addWorkoutPlan:(id)sender;

@end
