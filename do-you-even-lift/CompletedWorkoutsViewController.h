//
//  CompletedWorkoutsViewController.h
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UIColor+AppColors.h"
#import "QuartzCore/QuartzCore.h"
#import "CompletedWorkoutViewController.h"

@interface CompletedWorkoutsViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIView *tableGraphView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableGraphControl;
- (IBAction)tableGraphControlPressed:(id)sender;

@end
