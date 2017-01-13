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

@interface StartWorkoutViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation StartWorkoutViewController   {
    NSFetchedResultsController *_fetchedResultsController;
    UIButton *startButton;
    UITableView *tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Start Workout";
    
    startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startButton addTarget:self action:NSSelectorFromString(@"startButtonPressed") forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor greenColor];
    startButton.clipsToBounds = YES;
    startButton.frame = CGRectMake(self.view.frame.size.width*0.25, self.view.frame.size.height*0.2, self.view.frame.size.width*0.5, self.view.frame.size.height*0.05);
    startButton.enabled = NO;
    [self.view addSubview:startButton];

    
    UISwitch *onoff = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.425, self.view.frame.size.height*0.3,self.view.frame.size.width*0.1,self.view.frame.size.height*0.05)];
    [onoff addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:onoff];
    
    tableView=[[UITableView alloc]init];
    tableView.frame = CGRectMake(self.view.frame.size.width*0, self.view.frame.size.height*0.5,self.view.frame.size.width,self.view.frame.size.height*0.5);
    tableView.dataSource=self;
    tableView.delegate=self;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView.allowsMultipleSelection = NO;
    //[tableView reloadData];
    [self.view addSubview:tableView];
    
    
    // Do any additional setup after loading the view.
   
    NSError *error;
    //NSLog(@"%@", [self fetchedResultsController]);
    //_workouts= [context executeFetchRequest:fetchRequest error:&error];
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

-(IBAction)flip:(id)sender{
    UISwitch *onoff = (UISwitch * )sender;
    [startButton setTitle:@"Start New Plan" forState:UIControlStateNormal];
    
    NSIndexPath *path = [tableView indexPathForSelectedRow];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    if (cell.isSelected){
        [tableView deselectRowAtIndexPath:path animated:NO];
    }
    
    if(onoff.on){
        startButton.enabled = YES;
        //startButton.alpha = 0.5;
        tableView.allowsSelection = NO;
    }else{
        startButton.enabled = NO;
        //startButton.alpha = 1.0;
        tableView.allowsSelection = YES;
    }
}

-(void)startButtonPressed{
    //    self.isStart = !self.isStart;
    //
    //    if (self.isStart){
    //        sec = 0;
    //        min = 0;
    //        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick) userInfo:nil repeats:TRUE];
    //        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //        [startButton setTitle:@"STOP" forState:UIControlStateNormal];
    //    }else{
    //        [startButton setTitle:@"START" forState:UIControlStateNormal];
    //        [timer invalidate];
    //        label.text = [NSString stringWithFormat:@"00:00"];
    //    }
    //
    WorkoutDetailViewController* newWorkoutViewController = [[WorkoutDetailViewController alloc] init];
    NSIndexPath *path = [tableView indexPathForSelectedRow];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    if (cell.isSelected){
        newWorkoutViewController.workoutPlan = [_fetchedResultsController objectAtIndexPath:path];
    }
    
    [self showViewController:newWorkoutViewController sender:self];
    
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
    
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    // Configure the cell...
    
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
    
    id workoutPlan = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [workoutPlan valueForKey:@"plan_name"];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WorkoutDetail"]){
        WorkoutDetailViewController *controller = (WorkoutDetailViewController *)segue.destinationViewController;
        [controller startTimer:nil];
    }
}


#pragma mark - Core Data Interaction

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




/*
#pragma mark - Navigation
x
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
