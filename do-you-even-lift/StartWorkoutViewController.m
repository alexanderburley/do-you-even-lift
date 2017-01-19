//
//  StartWorkoutViewController.m
//  do-you-even-lift
//
//  Created by aca13ab on 11/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "StartWorkoutViewController.h"
#import "WorkoutDetailViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>

@interface StartWorkoutViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation StartWorkoutViewController   {
    
    NSFetchedResultsController *_fetchedResultsController;
    UIButton *startButton;
    UITableView *tableView;
    UISwitch *newPlanSwitch;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Start Workout";
    
    self.view.backgroundColor = [UIColor appWhiteColor];
    startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startButton addTarget:self action:NSSelectorFromString(@"startWorkoutButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"Select" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor appGreenColor];
    startButton.clipsToBounds = YES;
    startButton.layer.cornerRadius = self.view.frame.size.width*0.2;
    startButton.frame = CGRectMake(self.view.frame.size.width*0.3, self.view.frame.size.height*0.2, self.view.frame.size.width*0.4, self.view.frame.size.width*0.4);
    startButton.enabled = NO;
    [self.view addSubview:startButton];

    
    newPlanSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.7, self.view.frame.size.height*0.1,self.view.frame.size.width*0.15,self.view.frame.size.height*0.05)];
    [newPlanSwitch addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:newPlanSwitch];
    
    UILabel *newPlanLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.7, self.view.frame.size.height*0.15, self.view.frame.size.width*0.3, self.view.frame.size.height*0.05)];
    newPlanLabel.text = @"New Plan";
    [self.view addSubview:newPlanLabel];

    
    tableView=[[UITableView alloc]init];
    tableView.frame = CGRectMake(self.view.frame.size.width*0, self.view.frame.size.height*0.5,self.view.frame.size.width,self.view.frame.size.height*0.5);
    [tableView setSeparatorColor:[UIColor appGreenColor]];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView.allowsMultipleSelection = NO;
    tableView.backgroundColor = [UIColor appGreyColor];
    tableView.layer.borderWidth = 1;
    tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableView.separatorColor = [UIColor appGreenColor];
    
    [self.view addSubview:tableView];
   
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]){
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisapper:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(IBAction)switchPressed:(id)sender{
    [newPlanSwitch setOnTintColor:[UIColor orangeColor]];
    [startButton setTitle:@"Start New Plan" forState:UIControlStateNormal];
    
    NSIndexPath *path = [tableView indexPathForSelectedRow];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    
    if (cell.isSelected){
        [tableView deselectRowAtIndexPath:path animated:NO];
    }
    if(newPlanSwitch.on){
        startButton.enabled = YES;
        tableView.allowsSelection = NO;
    }
    else{
        startButton.enabled = NO;
        [startButton setTitle:@"Select" forState:UIControlStateNormal];
        tableView.allowsSelection = YES;
    }
}

-(void)startWorkoutButtonPressed{

    WorkoutDetailViewController* newWorkoutViewController = [[WorkoutDetailViewController alloc] init];
    NSIndexPath *path = [tableView indexPathForSelectedRow];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    WorkoutPlan *workoutPlan = [_fetchedResultsController objectAtIndexPath:path];
    if (cell.isSelected){
        newWorkoutViewController.workoutPlan = workoutPlan;
        //newWorkoutViewController.newWorkout = NO;
    }
    else {
        //newWorkoutViewController.newWorkout = YES;
    }
    
    [self showViewController:newWorkoutViewController sender:self];
    
}

-(void)returnToWorkoutScreen:(WorkoutDetailViewController*)newWorkoutViewController {
    
}

#pragma mark - Table Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAce;
    NSString *selectedPlanName = [[_fetchedResultsController objectAtIndexPath:indexPath] valueForKey:@"plan_name"];
    [startButton setTitle:[NSString stringWithFormat:@"Start %@", selectedPlanName] forState:UIControlStateNormal];
    startButton.enabled = YES;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    //startButton.titleLabel.text = @"Start";
    startButton.enabled = NO;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    WorkoutPlan *workoutPlan = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor appGreyColor];
    cell.textLabel.textColor = [UIColor appPurpleColor];
    cell.textLabel.text = workoutPlan.plan_name;
}


#pragma mark - Fetched Results Controller

-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WorkoutPlan" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plan_name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    
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
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [tableView endUpdates];
}


@end
