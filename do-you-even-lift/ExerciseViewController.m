//
//  ExerciseViewController.m
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "ExerciseViewController.h"
#import "AppDelegate.h"


@interface ExerciseViewController ()

@end

@implementation ExerciseViewController{
    NSArray *_muscle_groups;
    NSString *_selectedRow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _muscle_groups = [NSArray arrayWithObjects:@"Arms", @"Legs", @"Back",@"Chest",@"Shoulders",@"Upper Body", @"Lower Body", @"Cardio", nil];
    // Do any additional setup after loading the view from its nib.
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_muscle_groups count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_muscle_groups objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRow = [_muscle_groups objectAtIndex:row];
}



- (IBAction)saveButtonPressed:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.managedObjectContext;
    
    NSManagedObject *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
    [newExercise setValue:self.exerciseNameTextField.text forKey:@"exercise_name"];
    //[newExercise setValue:@([self.exerciseRepsTextField.text intValue]) forKey:@"reps"];
    //[newExercise setValue:@([self.exerciseSetsTextField.text intValue]) forKey:@"sets"];
    [newExercise setValue:_selectedRow forKey:@"muscle_group"];
    
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"Unable to save plan %@, %@", saveError, [saveError localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
