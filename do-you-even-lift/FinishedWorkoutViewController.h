//
//  FinishedWorkoutViewController.h
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "WorkoutDetailViewController.h"
#import "WorkoutPlan.h"


@interface FinishedWorkoutViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, FBSDKSharingDelegate>

@property (weak, nonatomic) IBOutlet UILabel *congratulationsLabel;
@property (strong,nonatomic) NSNumber *timeTaken;
@property (weak,nonatomic) WorkoutPlan *workoutPlan;
@property (weak,nonatomic) WorkoutDetailViewController *delegate;
- (IBAction)takePhotoButtonPressed:(id)sender;

- (IBAction)saveWorkoutButtonPressed:(id)sender;
- (IBAction)discardWorkoutButtonPressed:(id)sender;
- (IBAction)returnWorkoutButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *saveNewWorkoutPlanButton;
@property (weak, nonatomic) WorkoutDetailViewController *currentWorkoutController;
@property (weak, nonatomic) IBOutlet UIButton *discardWorkoutButton;

@end
