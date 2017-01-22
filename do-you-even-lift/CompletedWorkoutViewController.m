//
//  CompletedWorkoutViewController.m
//  do-you-even-lift
//
//  Created by Alex Burley on 22/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "CompletedWorkoutViewController.h"

@interface CompletedWorkoutViewController ()

@end

@implementation CompletedWorkoutViewController {
    NSFetchedResultsController *_fetchedResultsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    //self.title = @"Exercises";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView setBackgroundColor:[UIColor appGreyColor]];
    
    [self.tableView setSeparatorColor:[UIColor appBlueColor]];
    self.tableView.delegate = self;
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.tableView.allowsSelection = NO;
    self.workoutName.text = self.completedWorkout.workout_plan.plan_name;
    self.stepsCompletedLabel.text = [NSString stringWithFormat:@"%@", self.completedWorkout.steps];
    NSString *date_completed = [NSDateFormatter localizedStringFromDate:self.completedWorkout.date_completed
                                                              dateStyle:NSDateFormatterMediumStyle
                                                              timeStyle:NSDateFormatterNoStyle];
    self.dateCompletedLabel.text = date_completed;
    
    NSError *error;
    //NSLog(@"%@", [self fetchedResultsController]);
    if (![[self fetchedResultsController] performFetch:&error]){
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    CompletedWorkoutExercise *completedWorkoutExercise = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor appGreyColor];
    cell.textLabel.textColor = [UIColor appRedColor];
    cell.textLabel.text = completedWorkoutExercise.exercise.exercise_name;
    if ([completedWorkoutExercise.completed boolValue]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}

-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CompletedWorkoutExercise" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"completed_workout = %@", self.completedWorkout];
    fetchRequest.predicate = predicate;
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"muscle_group" ascending:YES];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"exercise.exercise_name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor1]];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
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


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_fetchedResultsController.managedObjectContext deleteObject:[_fetchedResultsController objectAtIndexPath:indexPath]];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[self.tableView reloadData];
        NSError *saveError = nil;
        if(![_fetchedResultsController.managedObjectContext save:&saveError]){
            NSLog(@"Unable delete exercise %@, %@", saveError, [saveError localizedDescription]);
        }
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [_fetchedResultsController sections][section];
    return [sectionInfo name];
}


@end