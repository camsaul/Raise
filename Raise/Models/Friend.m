//
//  Friend.m
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Friend.h"


@implementation Friend

@dynamic id;
@dynamic name;
@dynamic position;

- (UIImage *)image {
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"person_%@.jpg", self.id]];
	if (image) return image;
	return [UIImage imageNamed:[NSString stringWithFormat:@"person_%@.jpeg", self.id]];
}

@end
