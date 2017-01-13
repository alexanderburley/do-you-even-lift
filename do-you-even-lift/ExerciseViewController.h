//
//  ExerciseViewController.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *exerciseRepsTextField;
@property (weak, nonatomic) IBOutlet UITextField *exerciseSetsTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *muscleGroupPicker;
@property (weak, nonatomic) NSString *action;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;


@end
