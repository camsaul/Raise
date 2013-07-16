//
//  RaiseAlertView.m
//  Raise
//
//  Created by Cameron Saul on 7/15/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseAlertView.h"

@interface WCAlertView()
- (void)defaultStyle;
@end

@implementation RaiseAlertView

+ (void)initialize {
	[RaiseAlertView setDefaultCustomiaztonBlock:^(WCAlertView *alertView) {
		alertView.cornerRadius = 0;
		alertView.labelTextColor = [UIColor raiseDarkBlueColor];
		alertView.buttonTextColor = [UIColor raiseDarkBlueColor];
		
		alertView.titleFont = [UIFont fontWithName:@"Cabin-Bold" size:22];
		alertView.messageFont = [UIFont fontWithName:@"Cabin-Regular" size:16];
		alertView.buttonFont = [UIFont fontWithName:@"Cabin-Bold" size:18];

		alertView.gradientLocations = @[@0.0f, @1.0f];
		alertView.gradientColors = @[[UIColor whiteColor], [UIColor whiteColor]];
		
		alertView.outerFrameColor = [UIColor clearColor];
	}];
}

@end
