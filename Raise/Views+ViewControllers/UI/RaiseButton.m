//
//  RaiseButton.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseButton.h"

@implementation RaiseButton

+ (id)buttonWithType:(UIButtonType)buttonType {
	return [[RaiseButton alloc] init];
}

- (id)init {
	self = [super init];
	if (self) {
		[self style];
	}
	return self;
}

- (void)style {
	self.backgroundColor = [UIColor raiseLightBlueColor];
	// TODO - Needs some sort of highlighed BG
	
	self.titleLabel.font = [UIFont fontWithName:@"Cabin-Bold" size:16.0];
	[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.titleLabel.numberOfLines = 2;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self style];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.titleLabel.frame = CGRectInset(self.bounds, 5, 5);
}

@end
