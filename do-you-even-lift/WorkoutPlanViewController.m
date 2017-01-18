//
//  NewWorkoutPlanViewController.m
//  do-you-even-lift
//
//  Created by aca13ab on 12/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "WorkoutPlanViewController.h"
#import "AppDelegate.h"
#import "Exercise.h"
#import <CoreData/CoreData.h>

@interface WorkoutPlanViewController ()

@end

@implementation WorkoutPlanViewController {
    NSFetchedResultsController *_fetchedResultsController;
    NSArray *_fetchedExercises;
}

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

//SELECT ROW, ASSIGN DICTIONARY VALUE OF SETS AND REPS FROM ALERT VIEW CONTROLLER

- (void)viewDidLoad {
    
    self.title = @"Workout Plan";
    
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.backgroundColor = [UIColor appGreyColor];
    self.tableBackground.backgroundColor = [UIColor appGreyColor];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    if ([self.action  isEqualToString:@"read"]){
        self.tableView.allowsMultipleSelection = NO;
        self.cancelButton.enabled = NO;
        self.cancelButton.hidden = YES;
        self.saveButton.enabled = NO;
        self.saveButton.hidden = YES;
        self.planNameTextField.enabled = NO;
        self.planNameTextField.hidden = YES;
        self.nameLabel.hidden = YES;
        self.exerciseNameLabel.hidden = NO;
        self.exerciseNameLabel.text = self.viewedPlan.plan_name;
        _fetchedExercises = [self.viewedPlan getExercises];
        
    }
    
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]){
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveButtonPressed:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    
    NSString *name = self.planNameTextField.text;
    NSManagedObject *newPlan = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlan" inManagedObjectContext:context];
    [newPlan setValue:name forKey:@"plan_name"];
    
    NSArray *selectedExercises = [self.tableView indexPathsForSelectedRows];
    for (id cell in selectedExercises){
        NSManagedObject *newWorkoutPlanExercise = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutPlanExercise" inManagedObjectContext:context];
        [newWorkoutPlanExercise setValue:[_fetchedResultsController objectAtIndexPath:cell] forKey:@"exercise"];
        [newWorkoutPlanExercise setValue:newPlan forKey:@"workout_plan"];
    }
    
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.action  isEqualToString:@"read"]){
        return 1;
    }
    else {
        
        return [[_fetchedResultsController sections] count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.action  isEqualToString:@"read"]){
        return [_fetchedExercises count];
    }
    else {
        id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Exercise *exercise;
    
    if ([self.action isEqualToString:@"read"]){
        exercise = [_fetchedExercises objectAtIndex:indexPath.row];
    }
    else {
        exercise = [_fetchedResultsController objectAtIndexPath:indexPath];
    }
    
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

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.action isEqualToString:@"read"]){
        return @"All Exercises";
    }
    else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [_fetchedResultsController sections][section];
        return [sectionInfo name];
    }
}



-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"muscle_group" ascending:YES];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"exercise_name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor,sortDescriptor1]];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:@"muscle_group" cacheName:@"Root"];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}



@end
