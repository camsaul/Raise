//
//  FunnelYearsViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelYearsViewController.h"
#import "FunnelGaugeView.h"

@interface FunnelYearsViewController () <FunnelGaugeViewDelegate>
PROP int originalYears;
PROP_STRONG FunnelGaugeView *view;
@end

@implementation FunnelYearsViewController

- (void)loadView {
	self.originalYears = APP_DELEGATE.currentUser ? APP_DELEGATE.currentUser.yearsExperience.intValue : 2;
	self.view = [[FunnelGaugeView alloc] init];
	self.view.delegate = self;
	[self.view.titleLabel setTextPreservingExistingAttributes:@"I have this many years of job experience:"];
	
	self.view.gauge.minValue = 0;
	[self.view.minValueLabel setTextPreservingExistingAttributes:@"0 years"];
	self.view.gauge.maxValue = 20;
	[self.view.maxValueLabel setTextPreservingExistingAttributes:@"20+ years"];
	[self.view.valueLabel setTextPreservingExistingAttributes:[NSString stringWithFormat:@"%d%@ years", self.originalYears, (self.originalYears == 20 ? @"+" : @"")]];
	dispatch_next_run_loop(^{
		[self.view.gauge setValue:self.originalYears animated:YES];
		[self updateButtonEnabled:self.originalYears];
	});
	
	[self.view.continueButton addTarget:self action:@selector(continueButtonPressed)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Experience";
}

- (void)continueButtonPressed {
	int v = (int)roundf(self.view.gauge.value);
	
	APP_DELEGATE.currentUser.yearsExperience = @(v);
	self.originalYears = v;
	[self updateButtonEnabled:v];

	[self.delegate funnelViewControllerDidFinish];
}

- (void)updateButtonEnabled:(int)newValue {
	self.view.continueButton.enabled = !APP_DELEGATE.currentUser || newValue != self.originalYears;
}


#pragma mark - FunnelGaugeViewDelegate

- (NSString *)funnelGaugeViewStringForValue:(float)value {
	value = roundf(self.view.gauge.value); // round value to the nearest year
	[self updateButtonEnabled:(int)value];
	return [NSString stringWithFormat:@"%.0f%@ years", value, (value == 20.0f ? @"+" : @"")];
}

@end
