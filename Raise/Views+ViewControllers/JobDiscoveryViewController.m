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
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
}

- (IBAction)notInterestedButtonPressed:(id)sender {
	TODO_ALERT(@"show the next job");
}

- (IBAction)tellMeMoreButtonPressed:(id)sender {
	[NavigationService navigateTo:@"JobDetailPivotViewController" params:@{ParamJobID: @(100)}];
}

@end
