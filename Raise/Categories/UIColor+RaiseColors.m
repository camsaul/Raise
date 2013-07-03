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
	return [UIColor colorWithHexString:@"e6e7e8"];
}

+ (UIColor *)raiseDarkGrayColor {
	return [UIColor colorWithHexString:@"b3b3b3"];
}

+ (UIColor *)raiseBackgroundPattern {
	return [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_stripes.png"]];
}

+ (UIColor *)raiseVeryLightBlueColor {
	return [UIColor colorWithHexString:@"e2effa"];
}

+ (UIColor *)raiseLightBlueColor {
	return [UIColor colorWithHexString:@"a9c1d9"];
}

+ (UIColor *)raiseDarkBlueColor {
	return [UIColor colorWithHexString:@"607890"];
}

+ (UIColor *)raiseTransparentWhiteOverlayColor {
	return [UIColor colorWithWhite:1.0 alpha:0.9];
}

+ (UIColor *)raiseTransparentBlackOverlayColor {
	return [UIColor colorWithWhite:0.0 alpha:0.7];
}


@end
