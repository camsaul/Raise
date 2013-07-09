//
//  FunnelLocationViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelLocationViewController.h"

@interface FunnelLocationViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *finishedButton;
@property (strong, nonatomic) IBOutlet UIButton *anywhereButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation FunnelLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Location";
	self.textField.font = [UIFont fontWithName:@"Cabin-Bold" size:16.0];
	
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
}

- (void)hideKeyboard {
	[self.textField resignFirstResponder];
}

- (IBAction)anywhereButtonPressed:(id)sender {
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_check_80.png"];
	self.locationButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
}

- (IBAction)citiesButtonPressed:(id)sender {
	self.locationButton.imageView.image = [UIImage imageNamed:@"button_check_80.png"];
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];

}


- (IBAction)searchButtonPressed:(id)sender {
	[self.textField becomeFirstResponder];
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
	NSString *newString = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
	
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
