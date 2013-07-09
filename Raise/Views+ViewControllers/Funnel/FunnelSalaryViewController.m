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
PROP_STRONG FunnelGaugeView *view;
@end

@implementation FunnelSalaryViewController

- (void)loadView {
	self.view = [[FunnelGaugeView alloc] init];
	self.view.delegate = self;
	self.view.titleLabel.text = @"I'm looking for a job that will pay at least:";
	
	self.view.gauge.minValue = 20;
	self.view.minValueLabel.text = @"$20k";
	self.view.gauge.maxValue = 250;
	self.view.maxValueLabel.text = @"$250k+";
	self.view.valueLabel.text = @"$60k";
	dispatch_next_run_loop(^{
		[self.view.gauge setValue:60.0 animated:YES];
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
	TODO_ALERT(@"save the user's salary: %.0fk", value);
	
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - FunnelGaugeViewDelegate

- (NSString *)funnelGaugeViewStringForValue:(float)value {
	// round value to the nearest 5k
	int v = (int)roundf(value / 5.0);
	value = v * 5.0;
	return [NSString stringWithFormat:@"$%.0fk%@", value, (value == 250.0f ? @"+" : @"")];
}

@end
