//
//  FunnelNameViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelNameViewController.h"

@interface FunnelNameViewController ()
@property (strong, nonatomic) IBOutlet UIButton *continueButton;

@end

@implementation FunnelNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"Name";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)continueButtonPressed:(id)sender {
	[self.delegate funnelViewControllerDidFinish];
}

@end
