//
//  MenuViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

typedef enum : NSUInteger {
	MenuButtonDiscover,
	MenuButtonSearch,
	MenuButtonFollowing,
	MenubuttonSaved,
	MenuButtonDismiss,
	MenuButtonProfile
} MenuButton;

@protocol MenuViewControllerDelegate;


@interface MenuViewController : UIViewController
PROP_DELEGATE(MenuViewControllerDelegate);
@end


@protocol MenuViewControllerDelegate <NSObject>
- (void)menuViewControllerButtonPressed:(MenuButton)button;
@end