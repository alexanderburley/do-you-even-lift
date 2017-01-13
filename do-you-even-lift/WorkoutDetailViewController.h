//
//  WorkoutDetailViewController.h
//  do-you-even-lift
//
//  Created by Daniel Ayeni on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutPlan.h"

@interface WorkoutDetailViewController : UIViewController{
    
    UILabel *label;
    
    
}

@property(strong,nonatomic) WorkoutPlan *workoutPlan;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) NSTimer *timer;
-(void)timerFired:(NSTimer *)timer;
-(IBAction)startTimer:(id)sender;



@end
