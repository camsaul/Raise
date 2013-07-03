//
//  JobDiscoveryViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDiscoveryViewController.h"

@interface JobDiscoveryViewController ()

@end

@implementation JobDiscoveryViewController

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
	
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_navbar.png"]];
	
	UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	menuButton.backgroundColor = [UIColor orangeColor];
	UIImage *menuButtonImage = [UIImage imageNamed:@"button_side_menu.png"];
	[menuButton setImage:menuButtonImage forState:UIControlStateNormal];
	menuButton.frame = CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height);
	[menuButton addTarget:ROOT_VIEW_CONTROLLER action:@selector(menuButtonPressed)];
	UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
	self.navigationItem.leftBarButtonItem = menuButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
