//
//  NSDate+CreateDate.h
//  do-you-even-lift
//
//  Created by aca13ab on 19/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CreateDate)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end
