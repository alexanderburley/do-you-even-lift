//
//  WorkoutDetailViewController.m
//  do-you-even-lift
//
//  Created by Daniel Ayeni on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "WorkoutDetailViewController.h"
#import "StartWorkoutViewController.h"


@interface WorkoutDetailViewController () {
    
    
}


@end

@implementation WorkoutDetailViewController

int sec = 0;
int min = 0;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.3, 60, 30)];
    
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:label];
    label.text = [NSString stringWithFormat:@"00:00"];
    [self startTimer:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)startTimer:(id)sender{
    if (!self.timer){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo: nil repeats:YES];
    }
}

-(void)timerFired:(NSTimer *)timer{
    sec++;
    if (sec == 60)
    {
        sec = 0;
        min++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    //Display on your label
    
    label.text= timeNow;
    
}


@end
