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
PROP_STRONG FunnelGaugeView *view;
@end

@implementation FunnelYearsViewController

- (void)loadView {
	self.view = [[FunnelGaugeView alloc] init];
	self.view.delegate = self;
	self.view.titleLabel.text = @"I have this many years of job experience:";
	
	self.view.gauge.minValue = 0;
	self.view.minValueLabel.text = @"0 years";
	self.view.gauge.maxValue = 20;
	self.view.maxValueLabel.text = @"20+ years";
	self.view.valueLabel.text = @"2 years";
	dispatch_next_run_loop(^{
		[self.view.gauge setValue:2.0f animated:YES];
	});
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Experience";
}

- (void)continueButtonPressed {
	float value = roundf(self.view.gauge.value);
	TODO_ALERT(@"save the user's years of experience: %.0f years", value);
}


#pragma mark - FunnelGaugeViewDelegate

- (NSString *)funnelGaugeViewStringForValue:(float)value {
	value = roundf(self.view.gauge.value); // round value to the nearest year
	return [NSString stringWithFormat:@"%.0f%@ years", value, (value == 20.0f ? @"+" : @"")];
}

@end
