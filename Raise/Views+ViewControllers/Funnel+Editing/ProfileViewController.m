//
//  ProfileViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "ProfileViewController.h"
#import "FunnelViewController.h"
#import "LoginViewController.h"
#import "JobDiscoveryViewController.h"
#import "DataManager.h"

@interface ProfileViewController () <FunnelViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *salaryButton;
@property (strong, nonatomic) IBOutlet UIButton *yearsButton;
@property (strong, nonatomic) IBOutlet UIButton *citiesButton;
@property (strong, nonatomic) IBOutlet UIButton *dreamJobButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	// fix the buttons
	for (UIButton *button in @[self.salaryButton, self.yearsButton, self.citiesButton, self.dreamJobButton]) {
		button.titleLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:button.titleLabel.font.pointSize];
		button.titleLabel.numberOfLines = 2;
		[button.titleLabel sizeToFit];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	[self.nameLabel setTextPreservingExistingAttributes:APP_DELEGATE.currentUser.name];
	
	int value = APP_DELEGATE.currentUser.salary.intValue;
	[self.salaryButton setTitle:[NSString stringWithFormat:@"$%dk%@", value, (value == 250 ? @"+" : @"")] forState:UIControlStateNormal];
	
	value = APP_DELEGATE.currentUser.yearsExperience.intValue;
	[self.yearsButton setTitle:[NSString stringWithFormat:@"%d%@ years", value, (value == 20 ? @"+" : @"")] forState:UIControlStateNormal];
	
	NSString *locationsStr = nil;
	NSArray *selectedCities = [SearchCity selectedLocations];
	if (APP_DELEGATE.currentUser.searchAnywhere.boolValue || !selectedCities.count) {
		locationsStr = @"Anywhere";
	} else {
		if (selectedCities.count == 1) {
			locationsStr = [selectedCities[0] name];
		} else if (selectedCities.count == 2) {
			locationsStr = [NSString stringWithFormat:@"%@ and %@", [selectedCities[0] name], [selectedCities[1] name]];
		} else {
			locationsStr = [NSString stringWithFormat:@"%@, %@, and %d more", [selectedCities[0] name], [selectedCities[1] name], selectedCities.count - 2];
		}
	}
	[self.citiesButton setTitle:locationsStr forState:UIControlStateNormal];
	
	NSString *dream = @"Still figuring it out";
	Job *dreamJob = APP_DELEGATE.currentUser.dreamJob;
	Company *dreamCompany = APP_DELEGATE.currentUser.dreamCompany;
	if (dreamJob || dreamCompany) {
		if (dreamJob && dreamCompany) {
			dream = [NSString stringWithFormat:@"%@ at %@", dreamJob.title, dreamCompany.name];
		} else if (dreamJob) {
			dream = dreamJob.title;
		} else {
			dream = [NSString stringWithFormat:@"Any job at %@", dreamCompany.name];
		}
	}
	[self.dreamJobButton setTitle:dream forState:UIControlStateNormal];
}

- (IBAction)salaryButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelSalaryViewController" params:@{NavigationServiceDelegateParam: self}];
}

- (IBAction)experienceButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelYearsViewController" params:@{NavigationServiceDelegateParam: self}];
}

- (IBAction)locationButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelLocationViewController" params:@{NavigationServiceDelegateParam: self}];
}

- (IBAction)dreamJobButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelDreamJobViewController" params:@{NavigationServiceDelegateParam: self}];
}

- (IBAction)nameButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelNameViewController" params:@{NavigationServiceDelegateParam: self}];
}

- (IBAction)connectWithFacebookPressed:(id)sender {
	TODO_ALERT(@"connect with the user's Facebook account.");
}

- (IBAction)connectWithLinkedInPressed:(id)sender {
	TODO_ALERT(@"connect with the user's LinkedIn account.");
}

- (IBAction)logoutPressed:(id)sender {
	LoginViewController *loginVC = [[LoginViewController alloc] init];
	[ROOT_VIEW_CONTROLLER presentViewController:loginVC animated:YES completion:nil];
	
	[ROOT_VIEW_CONTROLLER setNavControllerRootVC:[JobDiscoveryViewController class] options:0];
}


#pragma mark - FunnelViewControllerDelegate

- (void)funnelViewControllerDidFinish {
	[APP_DELEGATE.rootViewController.navigationController popViewControllerAnimated:YES];
}

@end
