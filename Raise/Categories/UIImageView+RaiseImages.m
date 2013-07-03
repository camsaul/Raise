//
//  UIImageView+RaiseImages.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "UIImageView+RaiseImages.h"

@implementation UIImageView (RaiseImages)

+ (UIImageView *)raiseNavBarLogoImageView {
	return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_navbar.png"]];
}

@end
