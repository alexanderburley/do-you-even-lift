//
//  PersonalBest+CoreDataProperties.h
//  do-you-even-lift
//
//  Created by aca13ab on 13/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonalBest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalBest (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) Exercise *exercise;

@end

NS_ASSUME_NONNULL_END
