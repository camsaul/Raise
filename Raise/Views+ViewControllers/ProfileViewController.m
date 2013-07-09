//
//  ProfileViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
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
	
	// loop over all the labels and correct the font
	for (UILabel *label in self.view.subviews) {
		if (![label isKindOfClass:[UILabel class]]) continue;
		
		BOOL isBold = [label.font.fontName containsString:@"Bold"];
		CGFloat size = label.font.pointSize;
		
		label.font = [UIFont fontWithName:(isBold ? @"Cabin-Bold" : @"Cabin-Regular") size:size];
	}
	self.nameLabel.textColor = [UIColor raiseDarkBlueColor]; // for some reason nib is being ignored
	
	// fix the buttons
	for (UIButton *button in @[self.salaryButton, self.yearsButton, self.citiesButton, self.dreamJobButton]) {
		button.titleLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:button.titleLabel.font.pointSize];
		button.titleLabel.numberOfLines = 2;
		[button.titleLabel sizeToFit];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	self.nameLabel.text = APP_DELEGATE.currentUser.name;
	
	int value = APP_DELEGATE.currentUser.salary.intValue;
	[self.salaryButton setTitle:[NSString stringWithFormat:@"$%dk%@", value, (value == 250 ? @"+" : @"")] forState:UIControlStateNormal];
	
	value = APP_DELEGATE.currentUser.yearsExperience.intValue;
	[self.yearsButton setTitle:[NSString stringWithFormat:@"%d%@ Years", value, (value == 20 ? @"+" : @"")] forState:UIControlStateNormal];
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

- (IBAction)nameButtonPressed:(id)sender {
	[NavigationService navigateTo:@"FunnelNameViewController" params:nil];
}

- (IBAction)connectWithFacebookPressed:(id)sender {
	TODO_ALERT(@"connect with the user's Facebook accout.");
}

- (IBAction)connectWithLinkedInPressed:(id)sender {
	TODO_ALERT(@"connect with the user's LinkedIn accout.");
}

- (IBAction)logoutPressed:(id)sender {
	TODO_ALERT(@"log the user out.");
}

@end
