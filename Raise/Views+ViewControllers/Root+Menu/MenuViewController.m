//
//  MenuViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)discoverButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonDiscover];
}

- (IBAction)searchButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonSearch];
}

- (IBAction)followingButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonFollowing];
}

- (IBAction)dismissButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonDismiss];
}

- (IBAction)profileButtonPressed:(id)sender {
	[self.delegate menuViewControllerButtonPressed:MenuButtonProfile];
}

@end
