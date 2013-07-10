//
//  FunnelNavigationController.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelNavigationController.h"
#import "FunnelNameViewController.h"
#import "FunnelLocationViewController.h"
#import "FunnelDreamJobViewController.h"
#import "FunnelSalaryViewController.h"
#import "FunnelYearsViewController.h"
#import "FunnelDoneViewController.h"

@interface FunnelNavigationController () <FunnelViewControllerDelegate>
@end

@implementation FunnelNavigationController

- (id)init {
	return [super initWithRootViewController:[[FunnelNameViewController alloc] init]];
}

- (void)cancelButtonPressed {
	[self.presentingViewController dismissViewControllerAnimated:FunnelNavigationControllerFlagCancelled completion:nil];
}

- (void)pushViewController:(FunnelViewController *)viewController animated:(BOOL)animated {
	if (!self.viewControllers.count) { // first VC
		viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
	}
	[super pushViewController:viewController animated:animated];
	viewController.delegate = self;
}


#pragma mark - FunnelViewControllerDelegate

- (void)funnelViewControllerDidFinish {
	if ([self.topViewController isKindOfClass:[FunnelNameViewController class]]) {
		[NavigationService navigateTo:@"FunnelLocationViewController" params:nil];
		
	} else if ([self.topViewController isKindOfClass:[FunnelLocationViewController class]]) {
		[NavigationService navigateTo:@"FunnelDreamJobViewController" params:nil];
		
	} else if ([self.topViewController isKindOfClass:[FunnelDreamJobViewController class]]) {
		[NavigationService navigateTo:@"FunnelSalaryViewController" params:nil];
		
	} else if ([self.topViewController isKindOfClass:[FunnelSalaryViewController class]]) {
		[NavigationService navigateTo:@"FunnelYearsViewController" params:nil];
		
	} else if ([self.topViewController isKindOfClass:[FunnelYearsViewController class]]) {
		[NavigationService navigateTo:@"FunnelDoneViewController" params:nil];
		
	} else if ([self.topViewController isKindOfClass:[FunnelDoneViewController class]]) {
		[self.presentingViewController dismissViewControllerAnimated:FunnelNavigationControllerFlagFinished completion:nil];
	}
}

@end
