//
//  FunnelLocationViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FunnelLocationViewController.h"
#import "LocationResultCell.h"
#import "DataManager.h"

static NSString *LocationCellID = @"locationCellID";

@interface FunnelLocationViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *finishedButton;
@property (strong, nonatomic) IBOutlet UIButton *anywhereButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *citiesLabel;
PROP_STRONG NSArray *locations;
@end

@implementation FunnelLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Location";
	self.textField.font = [UIFont fontWithName:@"Cabin-Bold" size:16.0];
	
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
	
	self.tableView.alpha = 0;
	[self.tableView registerNib:[UINib nibWithNibName:@"LocationResultCell" bundle:Nil] forCellReuseIdentifier:LocationCellID];
	
	self.locations = [DataManager allObjectsOfType:DataTypeSearchCity];
	[self updateCitiesLabel];
	
	if (APP_DELEGATE.currentUser.searchAnywhere.boolValue) {
		self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_check_80.png"];
		self.locationButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
	}
}

- (void)hideKeyboard {
	[self.textField resignFirstResponder];
	[self.view removeHiddenButton];
}

- (IBAction)anywhereButtonPressed:(id)sender {
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_check_80.png"];
	self.locationButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
	APP_DELEGATE.currentUser.searchAnywhere = @(YES);
}

- (IBAction)citiesButtonPressed:(id)sender {
	self.locationButton.imageView.image = [UIImage imageNamed:@"button_check_80.png"];
	self.anywhereButton.imageView.image = [UIImage imageNamed:@"button_close_80.png"];
	APP_DELEGATE.currentUser.searchAnywhere = @(NO);
}

- (IBAction)completionButtonPressed:(id)sender {
	[self.delegate funnelViewControllerDidFinish];
}

- (IBAction)searchButtonPressed:(id)sender {
	if (!self.textField.isFirstResponder) {
		[self.textField becomeFirstResponder];
	} else {
		[self.textField resignFirstResponder];
	}
}

- (void)removePopunder {
	[UIView animateWithDuration:0.4 animations:^{
		self.tableView.alpha = 0;
	}];
}

- (void)updateSearchMatches:(NSString *)newText {
	self.locations = newText
	? [DataManager objectsOfType:DataTypeSearchCity withPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", newText]]
	: [DataManager allObjectsOfType:DataTypeSearchCity];
	
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateCitiesLabel {
	NSArray *selectedLocations = [SearchCity selectedLocations];
	NSUInteger numLocations = selectedLocations.count;
	if (!selectedLocations.count) {
		self.citiesLabel.text = @"Search for a location";
	} else if (selectedLocations.count == 1) {
		self.citiesLabel.text = [selectedLocations[0] name];
	} else if (selectedLocations.count == 2) {
		self.citiesLabel.text = [NSString stringWithFormat:@"%@ and %@", [selectedLocations[0] name],
								 [selectedLocations[1] name]];
	} else {
		self.citiesLabel.text = [NSString stringWithFormat:@"%@, %@, and %d more,",
								 [selectedLocations[0] name], [selectedLocations[1] name],
								 numLocations - 2];
	}
}


#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[UIView animateWithDuration:0.4 animations:^{
		self.tableView.alpha = 1;
	}];
	
	[self.view addHiddenButton];
	[self.view.hiddenButton addTarget:self action:@selector(hideKeyboard)];
	[self.view bringSubviewToFront:self.tableView];
	[self.view bringSubviewToFront:self.textField.superview];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *newString = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
	
	dispatch_next_run_loop(^{
		[self updateSearchMatches:newString];
		[self updateCitiesLabel];
	});
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self removePopunder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self removePopunder];
	[self.textField resignFirstResponder];
	
	return YES;
}


#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return MAX(self.locations.count, 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LocationResultCell *cell = (LocationResultCell *)[tableView dequeueReusableCellWithIdentifier:LocationCellID forIndexPath:indexPath];
	if (!self.locations.count) {
		cell.locationName = @"NO RESULTS";
		cell.checked = NO;
		return cell;
	}
	
	SearchCity *sc  = self.locations[indexPath.row];
	cell.locationName = sc.name;
	cell.checked = sc.selected.boolValue;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (!self.locations.count) return;
	
	SearchCity *sc  = self.locations[indexPath.row];
	LocationResultCell *cell = (LocationResultCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	self.textField.text = cell.locationName;
	cell.checked = !cell.checked;
	sc.selected = @(!sc.selected.boolValue);
	
	[self updateCitiesLabel];
}

@end
