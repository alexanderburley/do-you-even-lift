//
//  FinishedWorkoutViewController.m
//  do-you-even-lift
//
//  Created by Alex Burley on 15/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "FinishedWorkoutViewController.h"
#import "CoreData/CoreData.h"
#import "AppDelegate.h"

@interface FinishedWorkoutViewController ()

@end

@implementation FinishedWorkoutViewController {
    
    UIImagePickerController *imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    int min = [self.timeTaken intValue]/60;
    int sec = [self.timeTaken intValue]%60;
    self.congratulationsLabel.numberOfLines = 0;
    self.congratulationsLabel.text = [NSString stringWithFormat:@"Congratulations! You completed your workout in %i minutes and %i seconds. During this workout you completed over XXX steps and completed XX exercises", min, sec];

    imagePickerController = [[UIImagePickerController alloc] init];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.takePhotoButton.enabled = NO;
        self.takePhotoButton.alpha = 0.5;
    }
    else {
        self.takePhotoButton.enabled = YES;
        self.takePhotoButton.alpha = 1.0;
    }
    
    for (NSIndexPath *exerciseIndex in [self.currentWorkoutController.tableView indexPathsForSelectedRows]){
        Exercise *exercise = [self.currentWorkoutController.exercises objectAtIndex:exerciseIndex.row];
        NSLog(@"%@", exercise.exercise_name);
    }
    for (NSIndexPath *exerciseIndex in [self.currentWorkoutController getUnselectedExercises]){
        Exercise *exercise = [self.currentWorkoutController.exercises objectAtIndex:exerciseIndex.row];
        NSLog(@"%@", exercise.exercise_name);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)takePhotoButtonPressed:(id)sender{
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


- (IBAction)saveWorkoutButtonPressed:(id)sender {
    
    NSArray *quotes;
    quotes = [NSArray arrayWithObjects: @"Yeah, I had a girlfriend once, but she couldn’t spot me, so what was the point?", @"Of course its heavy, thats why they call it weight", nil];
    
    NSUInteger random = arc4random() % [quotes count];
    NSString *random_quotes = [quotes objectAtIndex: random];
    
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = random_quotes;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    
    CompletedWorkout *newCompletedWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorkout" inManagedObjectContext:context];
    [newCompletedWorkout setValue:[NSDate date] forKey:@"date_completed"];
    [newCompletedWorkout setValue:self.timeTaken forKey:@"time_taken"];
    [newCompletedWorkout setValue:self.workoutPlan forKey:@"workout_plan"];
    
    
    for (int section = 0; section < [self.currentWorkoutController.tableView numberOfSections]; section++) {
        for (int row = 0; row < [self.currentWorkoutController.tableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.currentWorkoutController.tableView cellForRowAtIndexPath:indexPath];
            [self.currentWorkoutController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            CompletedWorkoutExercise *newCompletedWorkoutExercise=[NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorkoutExercise" inManagedObjectContext:context];
            newCompletedWorkoutExercise.exercise = self.currentWorkoutController.exercises[indexPath.row];
            newCompletedWorkoutExercise.completed_workout = newCompletedWorkout;
            if ([cell isSelected]){
                newCompletedWorkoutExercise.completed = [NSNumber numberWithBool:YES];
            }
            else {
                newCompletedWorkoutExercise.completed = [NSNumber numberWithBool:NO];
            }
        }
    }
    

    
    //[newCompletedWorkout setValue:[self.steps] forKey:@"steps"];
    
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
    }
    self.currentWorkoutController.workoutPlan = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];

    
}

- (IBAction)returnWorkoutButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)discardWorkoutButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [[self presentedViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[[FBSDKSharePhoto photoWithImage:photo userGenerated:YES]];
    [FBSDKShareAPI shareWithContent:content delegate:self];
}

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
}
@end
