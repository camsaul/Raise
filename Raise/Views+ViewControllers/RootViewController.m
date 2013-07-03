//
//  RootViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "MenuViewController.h"
#import "JobDiscoveryViewController.h"

static const CGFloat AnimationDuration = 0.3;

@interface RootViewController ()
PROP_STRONG MenuViewController *menuViewController;
PROP_STRONG UINavigationController *navigationController;
@end

@implementation RootViewController

- (id)init {
	self = [super init];
	if (self) {
		self.menuViewController = [[MenuViewController alloc] init];
		
		JobDiscoveryViewController *jobDiscoveryVC = [[JobDiscoveryViewController alloc] init];
		self.navigationController = [[UINavigationController alloc] initWithRootViewController:jobDiscoveryVC];
		self.navigationController.navigationBar.tintColor = [UIColor raiseLightGrayColor];
		[NavigationService setNavigationController:self.navigationController];
	}
	return self;
}

- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIView *menuView = self.menuViewController.view;
	menuView.frame = CGRectMake(0, 0, 120, 460);
	menuView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
//	menuView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:menuView];
//	[self.view addConstraints:@[@"V:|[menuView]|", @"|[menuView(==200)]-(>=120)-|"] views:NSDictionaryOfVariableBindings(menuView)];
//	[self.view layoutSubviews];
	
	UIView *navControllerView = self.navigationController.view;
	navControllerView.backgroundColor = [UIColor raiseLightGrayColor];
//	navControllerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:navControllerView];
	navControllerView.frame = self.view.bounds;
	navControllerView.autoresizingMask = UIViewAutoresizingFlexibleSize;
//	[self.view addConstraints:@[@"|[navControllerView]|", @"V:|[navControllerView]|"] views:NSDictionaryOfVariableBindings(navControllerView)];
	[self.view layoutSubviews];
}

- (void)menuButtonPressed {
	// slide the navigation controller to reveal the menu
	NSLog(@"menu button pressed");
	UIView *navControllerView = self.navigationController.view;
	navControllerView.layer.shadowOffset = CGSizeMake(-1, 0);
	navControllerView.layer.shadowOpacity = 0.5;
	navControllerView.layer.shadowColor = [UIColor blackColor].CGColor;
	
	[navControllerView addHiddenButton];
	[navControllerView.hiddenButton addTarget:self action:@selector(navHiddenButtonPressed)];
	[UIView animateWithDuration:AnimationDuration animations:^{
		navControllerView.xOrigin = 120;
		navControllerView.alpha = 0.6;
	}];
}

- (void)navHiddenButtonPressed {
	UIView *navControllerView = self.navigationController.view;
	[navControllerView removeHiddenButton];
	[UIView animateWithDuration:AnimationDuration animations:^{
		navControllerView.xOrigin = 0;
		navControllerView.alpha = 1;
	}];
}

@end
