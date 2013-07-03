//
//  RootViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "JobDiscoveryViewController.h"

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
	}
	return self;
}

- (void)loadView {
	self.view = [[UIView alloc] init];
	self.view.backgroundColor = [UIColor magentaColor];
	
	UIView *menuView = self.menuViewController.view;
	menuView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:menuView];
	[self.view addConstraints:@[@"V:|[menuView]|", @"|[menuView(==200)]-(>=120)-|"] views:NSDictionaryOfVariableBindings(menuView)];
	[self.view layoutSubviews];
	
	UIView *navControllerView = self.navigationController.view;
	navControllerView.backgroundColor = [UIColor raiseLightGrayColor];
//	navControllerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:navControllerView];
	navControllerView.frame = self.view.bounds;
	navControllerView.autoresizingMask = UIViewAutoresizingFlexibleSize;
	[self.view addConstraints:@[@"|[navControllerView]|", @"V:|[navControllerView]|"] views:NSDictionaryOfVariableBindings(navControllerView)];
	[self.view layoutSubviews];
}

@end
