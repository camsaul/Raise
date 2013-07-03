//
//  MenuView.h
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate;


@interface MenuView : UIView

PROP_DELEGATE(MenuViewDelegate);

@end


@protocol MenuViewDelegate <NSObject>
@end
