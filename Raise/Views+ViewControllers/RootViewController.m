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
#import "FollowingViewController.h"
#import "LoginViewController.h"

static const CGFloat AnimationDuration = 0.3;

@interface RootViewController () <MenuViewControllerDelegate>
PROP_STRONG MenuViewController *menuViewController;
PROP_STRONG UIView *navViewWrapper; // this does all the actual sliding
PROP_STRONG UINavigationController *navigationController;
@end

@implementation RootViewController

- (id)init {
	self = [super init];
	if (self) {
		self.menuViewController = [[MenuViewController alloc] init];
		self.menuViewController.delegate = self;
	}
	return self;
}

- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	
	UIView *menuView = self.menuViewController.view;
	menuView.frame = CGRectMake(0, 0, 120, 460);
	menuView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
	[self.view addSubview:menuView];
	
	self.navViewWrapper = [[UIView alloc] initWithFrame:self.view.bounds];
	self.navViewWrapper.backgroundColor = [UIColor whiteColor];
	self.navViewWrapper.autoresizingMask = UIViewAutoresizingFlexibleSize;
	self.navViewWrapper.layer.shadowOffset = CGSizeMake(-1, 0);
	self.navViewWrapper.layer.shadowOpacity = 0.5;
	self.navViewWrapper.layer.shadowColor = [UIColor blackColor].CGColor;

	[self.view addSubview:self.navViewWrapper];
	
	[self setNavControllerRootVC:[JobDiscoveryViewController class]];
}

- (void)setNavControllerRootVC:(Class)class {
	BOOL existing = self.navigationController != nil;
	
	if ([self.navigationController.viewControllers[0] isKindOfClass:class]) return; // nothing to do
	
	UIViewController *rootVC = [[class alloc] init];
	
	if (existing) {
		UINavigationController *oldNavVC = self.navigationController;
		[UIView animateWithDuration:AnimationDuration animations:^{
			oldNavVC.view.alpha = 0;
		} completion:^(BOOL finished) {
			[oldNavVC.view removeFromSuperview];
		}];
	}
		
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
	self.navigationController.navigationBar.tintColor = [UIColor raiseLightGrayColor];
	[NavigationService setNavigationController:self.navigationController];
	
	UIView *navControllerView = self.navigationController.view;
	navControllerView.frame = self.navViewWrapper.bounds;
	[navControllerView layoutSubviews];
	navControllerView.backgroundColor = [UIColor raiseLightGrayColor];
	[self.navViewWrapper addSubview:navControllerView];

	navControllerView.autoresizingMask = UIViewAutoresizingFlexibleSize;
	
	if (existing) {
		navControllerView.alpha = 0;
		[UIView animateWithDuration:AnimationDuration animations:^{
			navControllerView.alpha = 1;
		}];
	}
}

- (void)menuButtonPressed {
	// slide the navigation controller to reveal the menu
	NSLog(@"menu button pressed");
	
	[self.navViewWrapper addHiddenButton];
	[self.navViewWrapper.hiddenButton addTarget:self action:@selector(navHiddenButtonPressed)];
	[UIView animateWithDuration:AnimationDuration animations:^{
		self.navViewWrapper.xOrigin = 120;
		self.navViewWrapper.alpha = 0.6;
	}];
}

- (void)navHiddenButtonPressed {
	[self hideMenu];
}

- (void)hideMenu {
	[self.navViewWrapper removeHiddenButton];
	[UIView animateWithDuration:AnimationDuration animations:^{
		self.navViewWrapper.xOrigin = 0;
		self.navViewWrapper.alpha = 1;
	}];
}


#pragma mark - MenuViewControllerDelegate

- (void)menuViewControllerButtonPressed:(MenuButton)button {
	switch (button) {
		case MenuButtonDiscover:	[self setNavControllerRootVC:[JobDiscoveryViewController class]]; break;
		case MenuButtonFollowing:	[self setNavControllerRootVC:[FollowingViewController class]]; break;
		case MenuButtonSearch:		TODO_ALERT(@"Show the search page."); break;
		case MenuButtonDismiss:		break;
		case MenuButtonProfile:		[self setNavControllerRootVC:[LoginViewController class]]; break;
	}
	[self hideMenu];
}

@end
