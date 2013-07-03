//
//  FollowingViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingViewController.h"

@interface FollowingViewController ()

@end

@implementation FollowingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
