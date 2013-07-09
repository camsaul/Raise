//
//  FunnelDreamJobViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelDreamJobViewController.h"

@interface FunnelDreamJobViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *figuringItOutButton;
@property (strong, nonatomic) IBOutlet UIButton *yesIWantToButton;
@property (strong, nonatomic) IBOutlet UIButton *specifiyCompanyButton;
@property (strong, nonatomic) IBOutlet UIButton *specifyPositionButton;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UITextField *companyTextField;
@property (strong, nonatomic) IBOutlet UITextField *positionTextField;

PROP BOOL specifyCompany;
PROP BOOL specifyPosition;

@end

@implementation FunnelDreamJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.navigationItem.titleView = nil;
	self.navigationItem.title = @"Dream Job";
	
	self.specifyCompany = YES;
	self.specifyPosition = NO;
}

- (IBAction)continueButtonPressed:(id)sender {
	[self.delegate funnelViewControllerDidFinish];
}

- (IBAction)figuringItOutButtonPressed:(id)sender {
	[self.figuringItOutButton setImage:[UIImage imageNamed:@"button_check_80.png"] forState:UIControlStateNormal];
	[self.yesIWantToButton setImage:[UIImage imageNamed:@"button_close_80.png"] forState:UIControlStateNormal];
	self.specifiyCompanyButton.enabled = NO;
	self.specifyPositionButton.enabled = NO;
}
- (IBAction)yesIWantToButtonPressed:(id)sender {
	[self.figuringItOutButton setImage:[UIImage imageNamed:@"button_close_80.png"] forState:UIControlStateNormal];
	[self.yesIWantToButton setImage:[UIImage imageNamed:@"button_check_80.png"] forState:UIControlStateNormal];
	self.specifiyCompanyButton.enabled = YES;
	self.specifyPositionButton.enabled = YES;
}

- (IBAction)specifyCompanyButtonPressed:(id)sender {
	self.specifyCompany = !self.specifyCompany;
	[self.specifiyCompanyButton setImage:(self.specifyCompany ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
}

- (IBAction)specifyPositionButtonPressed:(id)sender {
	self.specifyPosition = !self.specifyPosition;
	[self.specifyPositionButton setImage:(self.specifyPosition ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
}

- (void)hideKeyboard {
	[self.companyTextField resignFirstResponder];
	[self.positionTextField resignFirstResponder];
}

- (void)removePopunder {
	//	[UIView animateWithDuration:0.4 animations:^{
	//		self.searchPopunder.alpha = 0;
	//	} completion:^(BOOL finished) {
	//		[self.searchPopunder removeFromSuperview];
	//	}];
}

//- (BOOL)becomeFirstResponder {
//	[self.textField becomeFirstResponder];
//	return YES;
//}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	//	[self.view addSubview:self.searchPopunder];
	//	self.searchPopunder.origin = CGPointMake(10, self.textField.xOrigin + self.textField.height + 5);
	//	self.searchPopunder.alpha = 0;
	[UIView animateWithDuration:0.4 animations:^{
		//		self.searchPopunder.alpha = 1;
	}];
	
	[self.view addHiddenButton];
	[self.view.hiddenButton addTarget:self action:@selector(hideKeyboard)];
	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	NSLog(@"new string: %@", newString);
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self removePopunder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self removePopunder];
	return YES;
}

@end
