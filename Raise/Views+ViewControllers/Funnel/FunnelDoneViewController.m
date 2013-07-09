//
//  FunnelDoneViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelDoneViewController.h"

@interface FunnelDoneViewController ()
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@end

@implementation FunnelDoneViewController

- (IBAction)continueButtonPressed:(id)sender {
	[self.delegate funnelViewControllerDidFinish];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
}

@end
