//
//  FunnelNameViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelNameViewController.h"

@interface FunnelNameViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation FunnelNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Name";
	
	if (APP_DELEGATE.currentUser) {
		self.textField.text = APP_DELEGATE.currentUser.name;
		[self toggleContinueButton:APP_DELEGATE.currentUser.name];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.textField becomeFirstResponder];
}

- (void)toggleContinueButton:(NSString *)str {
	self.continueButton.enabled = !APP_DELEGATE.currentUser || ![APP_DELEGATE.currentUser.name isEqualToString:str];
}

- (IBAction)continueButtonPressed:(id)sender {
	APP_DELEGATE.currentUser.name = self.textField.text;
	[self.delegate funnelViewControllerDidFinish];
}

- (void)hideKeyboard {
	[self.view.superview removeHiddenButton];
	[self.textField resignFirstResponder];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[self.view.superview addHiddenButton];
	[self.view.superview.hiddenButton addTarget:self action:@selector(hideKeyboard)];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *newString = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
	[self toggleContinueButton:newString];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self hideKeyboard];
	[self toggleContinueButton:self.textField.text];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[self hideKeyboard];
	[self toggleContinueButton:self.textField.text];
	return YES;
}

@end
