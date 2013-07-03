//
//  UIColor+RaiseColors.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "UIColor+RaiseColors.h"

@implementation UIColor (RaiseColors)

+ (UIColor *)raiseLightGrayColor {
	return [UIColor colorWithHexString:@"e6e6e6"];
}

+ (UIColor *)raiseBackgroundPattern {
	return [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_stripes.png"]];
}

@end
