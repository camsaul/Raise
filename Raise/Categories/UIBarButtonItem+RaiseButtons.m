//
//  UIBarButtonItem+RaiseButtons.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "UIBarButtonItem+RaiseButtons.h"

@implementation UIBarButtonItem (RaiseButtons)

+ (UIBarButtonItem *)raiseMenuBarButtonItem {
	UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *menuButtonImage = [UIImage imageNamed:@"button_side_menu.png"];
	[menuButton setImage:menuButtonImage forState:UIControlStateNormal];
	menuButton.frame = CGRectMake(0, 0, menuButtonImage.size.width + 5, menuButtonImage.size.height);
//	menuButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
	menuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	menuButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	menuButton.clipsToBounds = YES;
	[menuButton addTarget:ROOT_VIEW_CONTROLLER action:@selector(menuButtonPressed)];
	UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
	return menuButtonItem;
}

@end
