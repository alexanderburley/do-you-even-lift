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
    int sec;
    int min;
    NSArray *_exercises;
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
        self.exercises = [self.workoutPlan getExercises];
    }
    else {
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = app.managedObjectContext;
        WorkoutPlan *newPlan = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlan" inManagedObjectContext:context];
        self.workoutPlan = newPlan;
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        //self.workoutPlan.plan_name = [NSString stringWithFormat:@"WorkoutPlan%ld-%ld-%ld", (long)[components day], (long)[components month], (long)[components year]];
        self.workoutPlan.plan_name = @"New Plan";
        self.workoutPlan.pre_made = [NSNumber numberWithBool:NO];
        self.workoutPlanNameLabel.text = self.workoutPlan.plan_name;
        UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addExercises:)];
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
    
    if ([self isMovingFromParentViewController]){
        if (self.newWorkout){
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = app.managedObjectContext;
            [context deleteObject:self.workoutPlan];
        }
    }
     
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
    
     self.exercises = [self.workoutPlan getExercises];
    [self.tableView reloadData];

}

#pragma mark - Intercace actions

-(IBAction)addExercises:(id)sender {
    ExercisesTableViewController* exercisesTableViewController = [[ExercisesTableViewController alloc] init];
    exercisesTableViewController.tableView.allowsMultipleSelection = YES;
    self.navigationController.navigationBar.topItem.title = @"Add";
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
    finishWorkoutViewController.currentWorkoutController = self;
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
    return [self.exercises count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Exercise *exercise = [self.exercises objectAtIndex:indexPath.row];
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

-(NSArray*)getUnselectedExercises {
    NSMutableArray *unselectedExercises = [[NSMutableArray alloc] init];
    for (int section = 0; section < [self.tableView numberOfSections]; section++) {
        for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
            if (![cell isSelected]){
                [unselectedExercises addObject:cellPath];
            }
            //do stuff with 'cell'
        }
    }
    return unselectedExercises;
}

- (CMPedometer *)pedometer {
    if (!_pedometer){
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
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
