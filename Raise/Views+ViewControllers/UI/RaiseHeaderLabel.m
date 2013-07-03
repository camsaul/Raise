//
//  RaiseHeaderLabel.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseHeaderLabel.h"

@implementation RaiseHeaderLabel

- (id)init {
	self = [super init];
	if (self) {
		[self style];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self style];
}

- (void)style {
	self.backgroundColor = [UIColor clearColor];
	self.textColor = [UIColor whiteColor];
	self.font = [UIFont fontWithName:@"Cabin-Bold" size:self.font.pointSize];
}


@end
