//
//  WorkoutPlan.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutPlan : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(NSArray*)getExercises;

@end

NS_ASSUME_NONNULL_END

#import "WorkoutPlan+CoreDataProperties.h"
