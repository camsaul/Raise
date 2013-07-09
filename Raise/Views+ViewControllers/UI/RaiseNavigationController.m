//
//  RaiseNavigationController.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseNavigationController.h"

@interface RaiseNavigationController ()
@end

@implementation RaiseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationBar.tintColor = [UIColor raiseLightBlueColor];
	[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar.png"] forBarMetrics:UIBarMetricsDefault];
	
	self.view.backgroundColor = [UIColor raiseLightGrayColor];
	self.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont fontWithName:@"Cabin-Bold" size:20.0],
											   UITextAttributeTextColor: [UIColor raiseDarkBlueColor],
											   UITextAttributeTextShadowColor: [UIColor clearColor]};
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[NavigationService setNavigationController:self];
}

@end
