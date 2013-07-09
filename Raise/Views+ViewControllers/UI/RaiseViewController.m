//
//  RaiseViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseViewController.h"

@interface RaiseViewController ()
@end

@implementation RaiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	
	// loop over all the labels and correct the font
	for (UILabel *label in self.view.subviews) {
		if (![label isKindOfClass:[UILabel class]]) continue;
		
		BOOL isBold = [label.font.fontName containsString:@"Bold"];
		CGFloat size = label.font.pointSize;
		
		label.font = [UIFont fontWithName:(isBold ? @"Cabin-Bold" : @"Cabin-Regular") size:size];
	}
}

@end
