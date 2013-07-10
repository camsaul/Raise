//
//  FunnelGaugeView.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelGaugeView.h"

@interface FunnelGaugeView ()
PROP_STRONG UIPanGestureRecognizer *gestureRecoginzer;
@end

@implementation FunnelGaugeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor raiseBackgroundPattern];
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 230, 50)];
		self.titleLabel.backgroundColor = [UIColor clearColor];
		self.titleLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:20.0];
		self.titleLabel.textColor = [UIColor raiseDarkBlueColor];
		self.titleLabel.numberOfLines = 2;
		[self addSubview:self.titleLabel];
		
		_continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.continueButton.frame = CGRectMake(250, 20, 50, 50);
		[self.continueButton setImage:[UIImage imageNamed:@"button_check_80.png"] forState:UIControlStateNormal];
		[self addSubview:self.continueButton];
		
		_gauge = [[MSSimpleGauge alloc] initWithFrame:CGRectMake(0, 180, 320, 170)];
		self.gauge.backgroundColor = [UIColor clearColor];
		self.gauge.backgroundArcFillColor = [UIColor raiseDarkGrayColor];
		self.gauge.backgroundArcStrokeColor = [UIColor clearColor];
		self.gauge.fillArcFillColor = [UIColor raiseDarkBlueColor];
		self.gauge.fillArcStrokeColor = [UIColor clearColor];
		self.gauge.needleView.needleColor = [UIColor blackColor];
		[self addSubview:self.gauge];
		
		_valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, 280, 45)];
		self.valueLabel.textAlignment = NSTextAlignmentCenter;		
		self.valueLabel.backgroundColor = [UIColor clearColor];
		self.valueLabel.font = [UIFont fontWithName:@"Cabin-Bold" size:40.0];
		self.valueLabel.textColor = [UIColor raiseDarkBlueColor];
		[self addSubview:self.valueLabel];
		
		_minValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 305, 80, 20)];
		self.minValueLabel.backgroundColor = [UIColor clearColor];
		self.minValueLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:14.0];
		self.minValueLabel.textColor = [UIColor raiseDarkBlueColor];
		[self addSubview:self.minValueLabel];
		
		_maxValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 305, 80, 20)];
		self.maxValueLabel.textAlignment = NSTextAlignmentRight;
		self.maxValueLabel.backgroundColor = [UIColor clearColor];
		self.maxValueLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:14.0];
		self.maxValueLabel.textColor = [UIColor raiseDarkBlueColor];
		[self addSubview:self.maxValueLabel];
		
		self.gestureRecoginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
		[self.gauge addGestureRecognizer:self.gestureRecoginzer];
		
    }
    return self;
}

- (void)pan {
	if (self.gestureRecoginzer.state == UIGestureRecognizerStateBegan) {
		
	} else if (self.gestureRecoginzer.state == UIGestureRecognizerStateChanged) {
		CGPoint touch = [self.gestureRecoginzer locationInView:self.gauge];
		CGFloat amount = touch.x / self.gauge.width;
		if (amount < 0.02) amount = 0; // "snap" to the edges (make it easier to get them)
		if (amount > 0.98) amount = 1.0f;
		float minValue = self.gauge.minValue;
		float maxValue = self.gauge.maxValue;
		self.gauge.value = roundf(minValue + (amount * (maxValue - minValue)));
		[self.valueLabel setTextPreservingExistingAttributes:[self.delegate funnelGaugeViewStringForValue:self.gauge.value]];
		
	} else if (self.gestureRecoginzer.state == UIGestureRecognizerStateEnded || self.gestureRecoginzer.state == UIGestureRecognizerStateCancelled) {
		
	}
}

@end
