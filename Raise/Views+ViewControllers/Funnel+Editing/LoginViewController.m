//
//  LoginViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "FunnelNavigationController.h"

@implementation LoginViewController

- (void)dismiss {
	[APP_DELEGATE login];
	[ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginLinkedInButtonPressed:(id)sender {
	[self dismiss];
}

- (IBAction)loginFacebookButtonPressed:(id)sender {
	[self dismiss];
}

- (IBAction)loginLaterButtonPressed:(id)sender {
	[APP_DELEGATE logout];
	FunnelNavigationController *funnelNavigationController = [[FunnelNavigationController alloc] init];
	[self presentViewController:funnelNavigationController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
	[super dismissViewControllerAnimated:YES completion:^{
		if (completion) completion();
		if (flag == FunnelNavigationControllerFlagFinished) {
			[self dismiss];
		}
	}];
}

@end
