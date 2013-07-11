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
#import "ProfileViewController.h"
#import "RaiseNavigationController.h"

static const CGFloat AnimationDuration = 0.3;

@protocol StartFocused
- (void)startFocused; // stop compiler complaining
@end

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
	
	[self setNavControllerRootVC:[JobDiscoveryViewController class] options:0];
}

- (void)setNavControllerRootVC:(Class)class options:(NavRootOptions)options {
	BOOL existing = self.navigationController != nil;
		
	UIViewController *rootVC = [[class alloc] init];
	
	if (existing) {
		UINavigationController *oldNavVC = self.navigationController;
		[UIView animateWithDuration:AnimationDuration animations:^{
			oldNavVC.view.alpha = 0;
		} completion:^(BOOL finished) {
			[oldNavVC.view removeFromSuperview];
		}];
	}
		
	self.navigationController = [[RaiseNavigationController alloc] initWithRootViewController:rootVC];
	
	UIView *navControllerView = self.navigationController.view;
	navControllerView.frame = self.navViewWrapper.bounds;
	[navControllerView layoutSubviews];

	[self.navViewWrapper addSubview:navControllerView];

	navControllerView.autoresizingMask = UIViewAutoresizingFlexibleSize;
	
	if (existing) {
		navControllerView.alpha = 0;
		[UIView animateWithDuration:AnimationDuration animations:^{
			navControllerView.alpha = 1;
		} completion:^(BOOL finished) {
			if (options & NavRootOptionStartFocused) {
				if ([rootVC respondsToSelector:@selector(startFocused)]) {
					[(id)rootVC startFocused];
				}
			}
		}];
	}
}

- (void)menuButtonPressed {
	// slide the navigation controller to reveal the menu
	NSLog(@"menu button pressed");
	
	[self.navViewWrapper addHiddenButton];
	[self.navViewWrapper.hiddenButton addTarget:self action:@selector(navHiddenButtonPressed)];
	[self.menuViewController viewWillAppear:YES];
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
	[self.menuViewController viewWillDisappear:YES];
	[UIView animateWithDuration:AnimationDuration animations:^{
		self.navViewWrapper.xOrigin = 0;
		self.navViewWrapper.alpha = 1;
	}];
}


#pragma mark - MenuViewControllerDelegate

- (void)menuViewControllerButtonPressed:(MenuButton)button {
	switch (button) {
		case MenuButtonDiscover:	[self setNavControllerRootVC:[JobDiscoveryViewController class] options:0]; break;
		case MenuButtonFollowing:	[self setNavControllerRootVC:[FollowingViewController class] options:0]; break;
		case MenuButtonSearch:		[self setNavControllerRootVC:[FollowingViewController class] options:NavRootOptionStartFocused]; break;
		case MenuButtonDismiss:		break;
		case MenuButtonProfile:		[self setNavControllerRootVC:[ProfileViewController class] options:0]; break;
	}
	[self hideMenu];
}

@end
