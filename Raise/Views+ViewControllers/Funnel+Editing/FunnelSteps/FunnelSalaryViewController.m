//
//  FunnelSalaryViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelSalaryViewController.h"
#import "FunnelGaugeView.h"

@interface FunnelSalaryViewController () <FunnelGaugeViewDelegate>
PROP int originalSalary;
PROP_STRONG FunnelGaugeView *view;
@end

@implementation FunnelSalaryViewController

- (void)loadView {
	self.originalSalary = APP_DELEGATE.currentUser ? APP_DELEGATE.currentUser.salary.intValue : 60;
	self.view = [[FunnelGaugeView alloc] init];
	self.view.delegate = self;
	[self.view.titleLabel setTextPreservingExistingAttributes:@"I'm looking for a job that will pay at least:"];
	
	self.view.gauge.minValue = 20;
	[self.view.minValueLabel setTextPreservingExistingAttributes:@"$20k"];
	self.view.gauge.maxValue = 250;
	[self.view.maxValueLabel setTextPreservingExistingAttributes:@"$250k+"];
	[self.view.valueLabel setTextPreservingExistingAttributes:[NSString stringWithFormat:@"$%dk%@", self.originalSalary, (self.originalSalary == 250 ? @"+" : @"")]];
	dispatch_next_run_loop(^{
		[self.view.gauge setValue:self.originalSalary animated:YES];
		[self updateButtonEnabled:self.originalSalary];
	});
	
	[self.view.continueButton addTarget:self action:@selector(continueButtonPressed)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Salary";
}

- (void)continueButtonPressed {
	int v = (int)roundf(self.view.gauge.value / 5.0);
	float value = v * 5.0;
	v = (int)roundf(value);
	
	APP_DELEGATE.currentUser.salary = @(v);
	self.originalSalary = v;
	[self updateButtonEnabled:v];
	
	[self.delegate funnelViewControllerDidFinish];
}

- (void)updateButtonEnabled:(int)newValue {
	self.view.continueButton.enabled = !APP_DELEGATE.userLoggedIn || newValue != self.originalSalary;
}


#pragma mark - FunnelGaugeViewDelegate

- (NSString *)funnelGaugeViewStringForValue:(float)value {
	// round value to the nearest 5k
	int v = (int)roundf(value / 5.0);
	value = v * 5.0;
	[self updateButtonEnabled:(int)roundf(value)];
	return [NSString stringWithFormat:@"$%.0fk%@", value, (value == 250.0f ? @"+" : @"")];
}

@end
