//
//  MenuViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"

@interface MenuViewController () <MenuViewDelegate>
PROP_STRONG MenuView *view;
@end

@implementation MenuViewController

- (MenuView  *)view {
  return (MenuView *)[super view];
}


#pragma mark - Memory Management / View Lifecycle

- (id)init {
  self = [super init];
  if (self) {

  }
  return self;
}

- (void)loadView {
  self.view = [[MenuView alloc] init];
  self.view.delegate = self;
}


#pragma mark - MenuViewDelegate


@end
