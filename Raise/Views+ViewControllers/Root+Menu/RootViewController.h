//
//  RootViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "MenuViewController.h"

typedef enum : int {
	NavRootOptionStartFocused = 1 << 0
} NavRootOptions;

@interface RootViewController : UIViewController

- (MenuViewController *)menuViewController;
- (UINavigationController *)navigationController;
- (void)setNavControllerRootVC:(Class)class options:(NavRootOptions)options;
- (void)menuButtonPressed;

@end
