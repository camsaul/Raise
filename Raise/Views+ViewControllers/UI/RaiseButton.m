//
//  RaiseButton.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseButton.h"

static UIImage *_backgroundImage;
static UIImage *_disabledBackgroundImage;

@implementation RaiseButton

+ (id)buttonWithType:(UIButtonType)buttonType {
	return [[RaiseButton alloc] init];
}

+ (UIImage *)backgroundImage {
	if (!_backgroundImage) {
		_backgroundImage = [UIImage imageWithColor:[UIColor raiseLightBlueColor] size:CGSizeMake(1, 1)];
	}
	return _backgroundImage;
}

+ (UIImage *)disabledBackgroundImage {
	if (!_disabledBackgroundImage) {
		_disabledBackgroundImage = [UIImage imageWithColor:[UIColor raiseDarkGrayColor] size:CGSizeMake(1, 1)];
	}
	return _disabledBackgroundImage;
}

- (id)init {
	self = [super init];
	if (self) {
		[self style];
	}
	return self;
}

- (void)style {
	[self setBackgroundImage:[RaiseButton backgroundImage] forState:UIControlStateNormal];
	[self setBackgroundImage:[RaiseButton disabledBackgroundImage] forState:UIControlStateDisabled];
	
	self.titleLabel.font = [UIFont fontWithName:@"Cabin-Bold" size:16.0];
	[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.titleLabel.numberOfLines = 2;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self style];
}

@end
