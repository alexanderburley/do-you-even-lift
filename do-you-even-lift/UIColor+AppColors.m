//
//  UIColor+AppColors.m
//  do-you-even-lift
//
//  Created by Alex Burley on 17/01/2017.
//  Copyright © 2017 Alex Burley. All rights reserved.
//

#import "UIColor+AppColors.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (AppColors)

+ (UIColor*)appBlueColor{
    return UIColorFromRGB(0x48beff);
}

+ (UIColor*)appRedColor{
    return UIColorFromRGB(0xee6352);
}

+ (UIColor*)appGreenColor{
    return UIColorFromRGB(0x4cc98d);
}

+ (UIColor*)appGreyColor{
    return UIColorFromRGB(0xf4f4f4);
}

+ (UIColor*)appWhiteColor{
    return UIColorFromRGB(0xfbf5f3);
}

+ (UIColor*)appPurpleColor{
    return UIColorFromRGB(0xb3a1cc);
}

@end
