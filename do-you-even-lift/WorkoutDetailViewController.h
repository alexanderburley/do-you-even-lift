//
//  WorkoutDetailViewController.h
//  do-you-even-lift
//
//  Created by aca13da on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutDetailViewController : UIViewController{
    
    UILabel *label;
   
    
}

@property (nonatomic, strong) NSTimer *timer;
-(void)timerFired:(NSTimer *)timer;
-(IBAction)startTimer:(id)sender;



@end
