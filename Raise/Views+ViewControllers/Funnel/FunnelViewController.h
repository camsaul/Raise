//
//  FunnelViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunnelViewControllerDelegate;

@interface FunnelViewController : RaiseViewController
PROP_DELEGATE(FunnelViewControllerDelegate);
@end

@protocol FunnelViewControllerDelegate <NSObject>
- (void)funnelViewControllerDidFinish;
@end
