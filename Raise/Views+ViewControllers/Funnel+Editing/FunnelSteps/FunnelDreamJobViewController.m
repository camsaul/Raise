//
//  FunnelDreamJobViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelDreamJobViewController.h"
#import "DataManager.h"

static NSString *CellID = @"CellID";

/// we'll tag our table view with this when it's being used to show jobs
static const int TableViewTagJobs = 999;
/// we'll tag our table view with this when it's being used to show companies
static const int TableViewTagCompanies = 998;

@interface FunnelDreamJobViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *figuringItOutButton;
@property (strong, nonatomic) IBOutlet UIButton *yesIWantToButton;
@property (strong, nonatomic) IBOutlet UIButton *specifiyCompanyButton;
@property (strong, nonatomic) IBOutlet UIButton *specifyPositionButton;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UITextField *companyTextField;
@property (strong, nonatomic) IBOutlet UITextField *positionTextField;
@property (strong, nonatomic) IBOutlet UITableView *searchPopover;

PROP BOOL figuringItOut;
//PROP BOOL specifyCompany;
//PROP BOOL specifyPosition;
PROP NSArray *filteredCompanies;
PROP NSArray *filteredJobs;
PROP Job *dreamJob;
PROP Company *dreamCompany;

@end

@implementation FunnelDreamJobViewController

- (Company *)dreamCompany {
	return APP_DELEGATE.currentUser.dreamCompany;
}

- (void)setDreamCompany:(Company *)dreamCompany {
	APP_DELEGATE.currentUser.dreamCompany = dreamCompany;
	self.companyTextField.text = dreamCompany.name;
}

- (Job *)dreamJob {
	return APP_DELEGATE.currentUser.dreamJob;
}

- (void)setDreamJob:(Job *)dreamJob {
	APP_DELEGATE.currentUser.dreamJob = dreamJob;
	self.positionTextField.text = dreamJob.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.navigationItem.titleView = nil;
	self.navigationItem.title = @"Dream Job";
	
	self.searchPopover.alpha = 0;
	[self.searchPopover registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
	
	self.filteredCompanies = [DataManager allObjectsOfType:DataTypeCompany];
	self.filteredJobs = [DataManager allObjectsOfType:DataTypeJob];
	
	self.dreamJob = APP_DELEGATE.currentUser.dreamJob;
	self.dreamCompany = APP_DELEGATE.currentUser.dreamCompany;
	
	self.figuringItOut = !self.dreamJob && !self.dreamCompany;
	[self updateButtons];
}

- (IBAction)continueButtonPressed:(id)sender {
	[self.delegate funnelViewControllerDidFinish];
}

- (void)updateButtons {
	[self.figuringItOutButton setImage:(self.figuringItOut ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
	[self.yesIWantToButton setImage:(!self.figuringItOut ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
	
	self.continueButton.enabled = self.figuringItOut || self.dreamCompany || self.dreamJob;
	
	self.specifiyCompanyButton.enabled = !self.figuringItOut;
	self.specifyPositionButton.enabled = !self.figuringItOut;
	[self.specifiyCompanyButton setImage:(self.dreamCompany ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
	[self.specifyPositionButton setImage:(self.dreamJob ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"]) forState:UIControlStateNormal];
}

- (IBAction)figuringItOutButtonPressed:(id)sender {
	self.figuringItOut = YES;
	self.dreamJob = nil;
	self.dreamCompany = nil;
	[self updateButtons];
}

- (IBAction)yesIWantToButtonPressed:(id)sender {
	self.figuringItOut = NO;
	[self updateButtons];
}

- (IBAction)specifyCompanyButtonPressed:(id)sender {
	if (self.dreamCompany) {
		self.dreamCompany = nil;
		[self updateButtons];
	} else {
		[self.companyTextField becomeFirstResponder];
	}
}

- (IBAction)specifyPositionButtonPressed:(id)sender {
	if (self.dreamJob) {
		self.dreamJob = nil;
		[self updateButtons];
	} else {
		[self.positionTextField becomeFirstResponder];
	}
}

- (void)hiddenButtonPressed {
	if (self.searchPopover.tag == TableViewTagCompanies) {
		self.dreamCompany = nil;
	} else {
		self.dreamJob = nil;
	}
	[self hideKeyboard];
}

- (void)hideKeyboard {
	[self.companyTextField resignFirstResponder];
	[self.positionTextField resignFirstResponder];
}

- (void)removePopover {
	[UIView animateWithDuration:0.4 animations:^{
		self.searchPopover.alpha = 0;
		self.view.hiddenButton.alpha = 0;
		self.companyTextField.backgroundColor = [UIColor clearColor];
		self.positionTextField.backgroundColor = [UIColor clearColor];
	} completion:^(BOOL finished) {
		[self.view.hiddenButton removeFromSuperview];
	}];
}

- (void)updateTableView:(NSString *)text {
	if (self.searchPopover.tag == TableViewTagCompanies) {
		self.filteredCompanies = text.length	? [DataManager objectsOfType:DataTypeCompany withPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", text]]
												: [DataManager allObjectsOfType:DataTypeCompany];
		[self.searchPopover reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
	} else {
		self.filteredJobs = text.length	? [DataManager objectsOfType:DataTypeJob withPredicate:[NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", text]]
										: [DataManager allObjectsOfType:DataTypeJob];
		[self.searchPopover reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.view addHiddenButton];
	[self.view.hiddenButton addTarget:self action:@selector(hiddenButtonPressed)];
	self.view.hiddenButton.backgroundColor = [UIColor raiseTransparentBlackOverlayColor];
	[self.view bringSubviewToFront:textField];
	[self.view bringSubviewToFront:self.searchPopover];
	self.searchPopover.tag = textField == self.companyTextField ? TableViewTagCompanies : TableViewTagJobs;
	[self updateTableView:textField.text];
	
	self.view.hiddenButton.alpha = 0;
	[UIView animateWithDuration:0.4 animations:^{
		self.searchPopover.alpha = 1;
		self.view.hiddenButton.alpha = 1;
		textField.backgroundColor = [UIColor whiteColor];
	}];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	[self updateTableView:[textField.text stringByReplacingCharactersInRange:range withString:string]];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self removePopover];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];

	if (textField == self.companyTextField) {
		self.dreamCompany = textField.text ? self.filteredCompanies[0] : nil;
	} else {
		self.dreamJob = textField.text ? self.filteredJobs[0] : nil;
	}
	[self updateButtons];
	
	return YES;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return tableView.tag == TableViewTagCompanies ? self.filteredCompanies.count : self.filteredJobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
	cell.textLabel.font = [UIFont fontWithName:@"Cabin-Regular" size:14.0];
	cell.textLabel.textColor = [UIColor raiseDarkBlueColor];
	
	cell.textLabel.text = tableView.tag == TableViewTagCompanies ? [self.filteredCompanies[indexPath.row] name] : [self.filteredJobs[indexPath.row] title];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.figuringItOut = NO;
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (tableView.tag == TableViewTagCompanies) {
		Company *c = [self.filteredCompanies objectAtIndex:indexPath.row];
		self.dreamCompany = c;
	} else {
		Job *j = [self.filteredJobs objectAtIndex:indexPath.row];
		self.dreamJob = j;
	}
	[self hideKeyboard];
	[self updateButtons];
}

@end
