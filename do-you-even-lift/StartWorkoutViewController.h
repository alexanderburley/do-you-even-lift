//
//  StartWorkoutViewController.h
//  do-you-even-lift
//
//  Created by aca13ab on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UIColor+AppColors.h"

@interface StartWorkoutViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

-(IBAction)switchPressed:(id)sender;



@end
