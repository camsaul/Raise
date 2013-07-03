//
//  MenuViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

@protocol MenuViewControllerDelegate;


@interface MenuViewController : UIViewController

PROP_DELEGATE(MenuViewControllerDelegate);

@end


@protocol MenuViewControllerDelegate <NSObject>
@end
