//
//  MenuViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation MenuViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	BKLog(LogFlagInfo, LogCategoryRootVCAndView, @"name: %@", APP_DELEGATE.currentUser.name);
	[self.nameLabel setTextPreservingExistingAttributes:APP_DELEGATE.currentUser.name];
	[self.view layoutIfNeeded];
}

- (IBAction)discoverButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonDiscover];
}

- (IBAction)searchButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonSearch];
}

- (IBAction)followingButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonFollowing];
}

- (IBAction)dismissButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonDismiss];
}

- (IBAction)profileButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonProfile];
}

@end
