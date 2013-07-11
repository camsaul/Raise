//
//  FollowingViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingViewController.h"
#import "FollowingTableViewCell.h"

static NSString *CellID = @"FollowingCompanyCell";
static const int CellImageViewTag = 2010;

@interface FollowingViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *searchPopunder;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FollowingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	self.textField.font = [UIFont fontWithName:@"Cabin" size:16.0];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
}

- (void)hideKeyboard {
	[self.textField resignFirstResponder];
}

- (IBAction)searchButtonPressed:(id)sender {
	[self.textField becomeFirstResponder];
}

- (void)removePopunder {
	[UIView animateWithDuration:0.4 animations:^{
		self.searchPopunder.alpha = 0;
	} completion:^(BOOL finished) {
		[self.searchPopunder removeFromSuperview];
	}];
}

- (BOOL)becomeFirstResponder {
	[self.textField becomeFirstResponder];
	return YES;
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.view addSubview:self.searchPopunder];
	self.searchPopunder.origin = CGPointMake(10, self.textField.xOrigin + self.textField.height + 5);
	self.searchPopunder.alpha = 0;
	[UIView animateWithDuration:0.4 animations:^{
		self.searchPopunder.alpha = 1;
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


#pragma mark - UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [Company followedCompanies].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	FollowingTableViewCell *cell = (FollowingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
	
	cell.company = [Company followedCompanies][indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Company *c = [Company followedCompanies][indexPath.row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	[NavigationService navigateTo:@"CompanyDetailViewController" params:@{ParamCompanyIDInt: c.id}];
}

@end
