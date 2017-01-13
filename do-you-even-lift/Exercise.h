//
//  Exercise.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Exercise : NSManagedObject

-(NSString *)getName;
-(NSString *)getMuscleGroup;
-(NSInteger *)getSets;
-(NSInteger *)getReps;

@end
