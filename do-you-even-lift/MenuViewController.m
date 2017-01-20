//
//  ViewController.m
//  do-you-even-lift
//
//  Created by Alex Burley on 07/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "MenuViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "CompletedWorkoutsViewController.h"

#define ARC4_RAND_MAC 0x1000000000


@interface MenuViewController () <FBSDKLoginButtonDelegate>



@end

@implementation MenuViewController{
    
    // FB User ID and full name
    NSString *_userID;
    NSString *_userName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.title = @"Menu";
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.13, self.view.frame.size.width*0.9, self.view.frame.size.height*0.05)];
    titleLabel.text = @"DO YOU EVEN LIFT?";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"OpenSans-Extrabold" size:25];
    [self.view addSubview:titleLabel];
    
    
    startWorkoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startWorkoutButton.layer.cornerRadius = 10;
    [startWorkoutButton addTarget:self action:NSSelectorFromString(@"startWorkoutButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    startWorkoutButton.backgroundColor = [UIColor appGreenColor];
    [startWorkoutButton setTitleColor:[UIColor appWhiteColor] forState:UIControlStateNormal];
    [startWorkoutButton setTitle:@"Start Workout" forState:UIControlStateNormal];
    startWorkoutButton.frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.22, self.view.frame.size.width*0.6, self.view.frame.size.height*0.10);
    //[self.view addSubview:startWorkoutButton];
    
    workoutsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    workoutsButton.layer.cornerRadius = 10;
    [workoutsButton addTarget:self action:NSSelectorFromString(@"workoutsButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [workoutsButton setTitleColor:[UIColor appWhiteColor] forState:UIControlStateNormal];
    workoutsButton.backgroundColor = [UIColor appBlueColor];
    [workoutsButton setTitle:@"Completed Workouts" forState:UIControlStateNormal];
    workoutsButton.frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.34, self.view.frame.size.width*0.6, self.view.frame.size.height*0.1);
    
    exercisesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    exercisesButton.layer.cornerRadius = 10;
    [exercisesButton addTarget:self action:NSSelectorFromString(@"exercisesButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [exercisesButton setTitleColor:[UIColor appWhiteColor] forState:UIControlStateNormal];
    exercisesButton.backgroundColor = [UIColor appRedColor];
    [exercisesButton setTitle:@"Exercises" forState:UIControlStateNormal];
    exercisesButton.frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.46, self.view.frame.size.width*0.6, self.view.frame.size.height*0.1);
    
    workoutPlansButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    workoutPlansButton.layer.cornerRadius = 10;
    [workoutPlansButton addTarget:self action:NSSelectorFromString(@"workoutPlansButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [workoutPlansButton setTitleColor:[UIColor appWhiteColor] forState:UIControlStateNormal];
    workoutPlansButton.backgroundColor = [UIColor appPurpleColor];
    [workoutPlansButton setTitle:@"Workout Plans" forState:UIControlStateNormal];
    workoutPlansButton.frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.58, self.view.frame.size.width*0.6, self.view.frame.size.height*0.1);
    //[self.view addSubview:workoutPlansButton];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.7, self.view.frame.size.width*0.6, self.view.frame.size.height*0.1);
    loginButton.readPermissions = @[@"public_profile"];
    [loginButton setDelegate:self];
    loginButton.layer.cornerRadius = 10;
    [self.view addSubview:loginButton];
    
    UILabel *copyright = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.9, self.view.frame.size.width*0.7, self.view.frame.size.height*0.1)];
    copyright.numberOfLines = 0;
    copyright.text = @"Do You Even Lift was designed and engineered by Alex Burley and Daniel Ayeni for the Software Development for Mobile Devices module at the University of Sheffield";
    copyright.textColor = [UIColor lightGrayColor];
    copyright.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:copyright];
    
   
    //If a user already has access we can process that and add the necessary view
    if ([FBSDKAccessToken currentAccessToken]){
        [self finishLogin];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    [exercisesButton removeFromSuperview];
    [startWorkoutButton removeFromSuperview];
    [workoutPlansButton removeFromSuperview];
    [workoutsButton removeFromSuperview];
    _userID = nil;
    _userName = nil;
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    //Seperate large code from delegate method
    [self finishLogin];
    
}

-(void)usersButtonPressed{
    [self performSegueWithIdentifier:@"showUsers" sender:self];
    
}

-(void)startWorkoutButtonPressed {
    self.navigationController.navigationBar.tintColor = [UIColor appGreenColor];
    [self performSegueWithIdentifier:@"startWorkout" sender:self];
    
}

-(void)workoutsButtonPressed{
    self.navigationController.navigationBar.tintColor = [UIColor appBlueColor];
    CompletedWorkoutsViewController *completedWorkoutsViewController = [[CompletedWorkoutsViewController alloc] init];
    [self showViewController:completedWorkoutsViewController sender:self];
    
}

-(void)workoutPlansButtonPressed{
    self.navigationController.navigationBar.tintColor = [UIColor appPurpleColor];
    [self performSegueWithIdentifier:@"workoutPlans" sender:self];
}

-(void)exercisesButtonPressed{
    self.navigationController.navigationBar.tintColor = [UIColor appRedColor];
    [self performSegueWithIdentifier:@"exercises" sender:self];
}

-(void)finishLogin{
    
    //If a user is logged in we want to give them access to the view users
    [self.view addSubview:startWorkoutButton];
    [self.view addSubview:workoutPlansButton];
    [self.view addSubview:workoutsButton];
    [self.view addSubview:exercisesButton];
    self.view.backgroundColor = [UIColor appWhiteColor];
    //Access the user identification number and set the instance variable
    NSLog(@"User ID: %@", [FBSDKAccessToken currentAccessToken].userID);
    _userID = [FBSDKAccessToken currentAccessToken].userID;
    
    //We only want to request the id and name of the user
    NSMutableDictionary* paramaters = [NSMutableDictionary dictionary];
    [paramaters setValue:@"id,name" forKey:@"fields"];
    //Use FB graph api to get the data. Note the completion handler, this operates asychronously and may lead to errors if you operate outside the block relying on objects that are set within in the block.
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:paramaters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id results, NSError *error) {
         
         //Set the name
         NSLog(@"Name: %@", [results valueForKey:@"name"]);
         _userName = [results valueForKey:@"name"];
         
         //Retrieve the application context using the public appdelegate method
         AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
         NSManagedObjectContext *context = app.managedObjectContext;
         
         //Initiate fetch request with a predicate to retrieve the necessary object(s)
         NSFetchRequest *request = [[NSFetchRequest alloc] init];
         request.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id = %@", _userID];
         request.predicate = predicate;
         NSError *requestError = nil;
         NSArray *objs = [context executeFetchRequest:request error:&requestError];
         
         if (requestError) {
             [NSException raise:@"Error on fetch request" format:@"%@", [requestError localizedDescription]];
         }
         else {
             if (objs.count > 0){
                 //Update the last login date
                 [[objs objectAtIndex:0] setValue:[NSDate date] forKey:@"last_login"];
             }
             else {
                 //Create a new object
                 NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
                 NSLog(@"user = %@", _userName);
                 [newUser setValue:_userID forKey:@"user_id"];
                 [newUser setValue:_userName forKey:@"name"];
                 [newUser setValue:[NSDate date] forKey:@"created_at"];
                 [newUser setValue:[NSDate date] forKey:@"last_login"];
                 
             }
         }
         
         NSError *saveError = nil;
         
         if(![context save:&saveError]){
             NSLog(@"Unable to save user %@, %@", saveError, [saveError localizedDescription]);
         }

     }];
    
}


@end
