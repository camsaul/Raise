//
//  RootViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "MenuViewController.h"

@interface RootViewController : UIViewController

- (MenuViewController *)menuViewController;
- (UINavigationController *)navigationController;

- (void)menuButtonPressed;

@end