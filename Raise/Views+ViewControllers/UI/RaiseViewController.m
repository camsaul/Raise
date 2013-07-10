//
//  RaiseViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RaiseViewController.h"

@interface RaiseViewController ()
@end

@implementation RaiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	
	[self.view correctFonts];
}

@end
