//
//  WorkoutDetailViewController.m
//  do-you-even-lift
//
//  Created by Daniel Ayeni on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "WorkoutDetailViewController.h"
#import "StartWorkoutViewController.h"
#import "FinishedWorkoutViewController.h"
#import "ExercisesTableViewController.h"
#import "AppDelegate.h"
#import "Exercise.h"
#import "UIColor+AppColors.h"


@interface WorkoutDetailViewController () <AddExercisesMidWorkout>
@end

@implementation WorkoutDetailViewController {
    NSArray *_exercises;
    NSFetchedResultsController *_fetchedResultsController;
    int sec;
    int min;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sec = 0;
    min = 0;
    self.view.backgroundColor = [UIColor appWhiteColor];
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    self.stepsLabel.text = [NSString stringWithFormat:@"0"];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.allowsMultipleSelection = true;
    self.tableView.backgroundColor = [UIColor appGreyColor];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.finishButton.layer.cornerRadius = 10;
    self.finishButton.backgroundColor = [UIColor appGreenColor];
    self.finishButton.titleLabel.textColor = [UIColor appWhiteColor];
    
    if (self.workoutPlan){
        self.workoutPlanNameLabel.text = self.workoutPlan.plan_name;
        _exercises = [self.workoutPlan getExercises];
    }
    else {
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = app.managedObjectContext;
        self.workoutPlanNameLabel.text = @"New Workout";
        WorkoutPlan *newPlan = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlan" inManagedObjectContext:context];
        self.workoutPlan = newPlan;
        self.workoutPlan.plan_name = @"New Plan";
        UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Exercises" style:UIBarButtonItemStylePlain target:self action:@selector(addExercises:)];
        self.navigationItem.rightBarButtonItem = newButton;
        
        NSError *saveError = nil;
        if(![context save:&saveError]){
            NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
        }
    }


    
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData *_Nullable pedometerData, NSError * _Nullable error ) {
        [self updateLabels:pedometerData];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    /*
    if ([self isMovingFromParentViewController]){
        if (self.newWorkout){
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = app.managedObjectContext;
            //[context deleteObject:self.workoutPlan];
        }
    }
     */
    [self pauseTimer:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [self startTimer:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didAddExercisesMidWorkout:(NSArray *)exercises{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    for (Exercise *exercise in exercises){
        NSManagedObject *newWorkoutPlanExercise = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlanExercise" inManagedObjectContext:context];
        [newWorkoutPlanExercise setValue:exercise forKey:@"exercise"];
        [newWorkoutPlanExercise setValue:self.workoutPlan forKey:@"workout_plan"];
    }
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"Unable to save exercises %@, %@", saveError, [saveError localizedDescription]);
    }
    
     _exercises = [self.workoutPlan getExercises];
    [self.tableView reloadData];

}

#pragma mark - Intercace actions

-(IBAction)addExercises:(id)sender {
    ExercisesTableViewController* exercisesTableViewController = [[ExercisesTableViewController alloc] init];
    exercisesTableViewController.tableView.allowsMultipleSelection = YES;
    exercisesTableViewController.navigationItem.backBarButtonItem.title = @"Add";
    exercisesTableViewController.midWorkoutDelegate = self;
    [self showViewController:exercisesTableViewController sender:self];
}

-(IBAction)startTimer:(id)sender{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo: nil repeats:YES];
    [self.timer fire];
}

-(IBAction)pauseTimer:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)finishButtonPressed:(id)sender {
    
    FinishedWorkoutViewController *finishWorkoutViewController = [[FinishedWorkoutViewController alloc] init];
    finishWorkoutViewController.navigationItem.hidesBackButton = YES;
    //finishWorkoutViewController.stepsCompleted = self.steps;
    finishWorkoutViewController.timeTaken = [NSNumber numberWithInt:sec+(min*60)];
//    finishWorkoutViewController.steps = [self.PedometerData.numberOfSteps];
    finishWorkoutViewController.workoutPlan = self.workoutPlan;
    finishWorkoutViewController.delegate = self;
    NSError *saveError = nil;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    if(![context save:&saveError]){
        NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
    }
    [self showViewController:finishWorkoutViewController sender:self];
    
    
    
}


-(void)updateLabels:(CMPedometerData *)pedometerData{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.maximumFractionDigits = 2;
    
    if ([CMPedometer isStepCountingAvailable]){
        self.stepsLabel.text = [NSString stringWithFormat:@" %@", [formatter stringFromNumber:pedometerData.numberOfSteps]];
    }else {
        self.stepsLabel.text = @"Steps Counter not available";
    }
}

-(void)timerFired:(NSTimer *)timer{
    sec++;
    if (sec == 60) {
        sec = 0;
        min++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    //Display on your label
    NSLog(@"%@",timeNow);
    self.timerLabel.text= timeNow;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [_exercises count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Exercise *exercise = [_exercises objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor appGreyColor];
    cell.textLabel.textColor = [UIColor appRedColor];
    cell.textLabel.text = exercise.exercise_name;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - Fetched results controller


-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"exercise_name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [fetchRequest setFetchBatchSize:20];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY workout_plan_exercise = %@", self.workoutPlan.workout_plan_exercise];
    
    fetchRequest.predicate = predicate;
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeMove:
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


//CREATE PROTOCOL!!


@end
