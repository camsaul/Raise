//
//  FollowingViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingViewController.h"
#import "FollowingTableViewCell.h"
#import "FollowingPopunderCell.h"
#import "DataManager.h"

static NSString *FollowingCellID = @"FollowingCompanyCell";
static NSString *PopunderCellID = @"PopunderCell";
static const int CellImageViewTag = 2010;

@interface FollowingViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *textField;
/// regular (following) tableview
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *popunderTableView;
PROP_STRONG NSArray *searchMatches;
@end

@implementation FollowingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	self.textField.font = [UIFont fontWithName:@"Cabin" size:16.0];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil] forCellReuseIdentifier:FollowingCellID];
	[self.popunderTableView registerNib:[UINib nibWithNibName:@"FollowingPopunderCell" bundle:nil] forCellReuseIdentifier:PopunderCellID];
	
	self.popunderTableView.alpha = 0;
	
	[self updateSearchMatches];
}

- (void)hideKeyboard {
	[self.view removeHiddenButton];
	[self.textField resignFirstResponder];
}

- (IBAction)searchButtonPressed:(id)sender {
	[self.textField becomeFirstResponder];	
}

- (void)removePopunder {
	[UIView animateWithDuration:0.4 animations:^{
		self.popunderTableView.alpha = 0;
	}];
}

- (void)startFocused {
	[self.textField becomeFirstResponder];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[UIView animateWithDuration:0.4 animations:^{
		self.popunderTableView.alpha = 1;
	}];
	
	[self.view addHiddenButton];
	[self.view.hiddenButton addTarget:self action:@selector(hideKeyboard)];
	[self.view bringSubviewToFront:self.popunderTableView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *newString = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
	
	NSLog(@"new string: %@", newString);
	
	dispatch_next_run_loop(^{
		[self updateSearchMatches];
	});
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self removePopunder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self removePopunder];
	[self hideKeyboard];
	return YES;
}

- (void)updateSearchMatches {
	self.searchMatches = self.textField.text
		? [DataManager objectsOfType:DataTypeCompany withPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", self.textField.text]]
		: [DataManager allObjectsOfType:DataTypeCompany];

	[self.popunderTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.tableView) {
		return [Company followedCompanies].count;
	} else {
		return MIN(self.searchMatches.count, 2);
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.tableView) {
		return 160;
	} else {
		return 60;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.tableView) {
		FollowingTableViewCell *cell = (FollowingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FollowingCellID forIndexPath:indexPath];
		cell.company = [Company followedCompanies][indexPath.row];
		return cell;
	} else {
		FollowingPopunderCell *cell = (FollowingPopunderCell *)[tableView dequeueReusableCellWithIdentifier:PopunderCellID forIndexPath:indexPath];
		cell.company = self.searchMatches[indexPath.row];
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Company *c = [(id)[tableView cellForRowAtIndexPath:indexPath] company];
	
	[tableView deselectRowAtIndexPath:indexPath animated:NO];

	[NavigationService navigateTo:@"CompanyDetailViewController" params:@{ParamCompanyIDInt: c.id}];
}

@end
