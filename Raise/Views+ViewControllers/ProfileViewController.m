//
//  ProfileViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	// TODO - Be an actual view controller and load user's profile info.
}

- (IBAction)salaryButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelSalaryViewController" params:nil];
}

- (IBAction)experienceButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelYearsViewController" params:nil];
}

- (IBAction)locationButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelLocationViewController" params:nil];
}

- (IBAction)dreamJobButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelDreamJobViewController" params:nil];
}

@end
