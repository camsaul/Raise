//
//  FollowingViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/3/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingViewController.h"

static NSString *CellID = @"FollowingCompanyCell";
static const int CellImageViewTag = 2010;

@interface FollowingViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *searchPopunder;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FollowingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	self.textField.font = [UIFont fontWithName:@"Cabin-Bold" size:16.0];
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
	return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellID];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
		cell.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor clearColor];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 140)];
		imageView.tag = CellImageViewTag;
		[cell addSubview:imageView];
	}
	
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:CellImageViewTag];
	imageView.image = [UIImage imageNamed:(indexPath.row % 2 ? @"following_cell_1.png" : @"following_cell_2.png")];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	[NavigationService navigateTo:@"CompanyDetailViewController" params:nil];
}

@end
