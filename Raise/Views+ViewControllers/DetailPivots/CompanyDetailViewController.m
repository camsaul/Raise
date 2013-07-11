//
//  CompanyDetailViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "CompanyDetailViewController.h"
#import "RaiseButton.h"
#import "DataManager.h"
#import "JobCollectionViewCell.h"
#import "CompanyCollectionViewCell.h"
#import "FriendCollectionViewCell.h"

@interface CompanyDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

PROP_STRONG Company *company;
PROP_STRONG NSArray *friends;
PROP_STRONG NSArray *jobs;
PROP_STRONG NSArray *similarCompanies;

@property (strong, nonatomic) IBOutlet RaiseButton *followButton;
@property (strong, nonatomic) IBOutlet UICollectionView *similarCompaniesCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *jobsCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *friendsCollectionView;
@property (strong, nonatomic) IBOutlet UITextView *companyDescriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CompanyDetailViewController

+ (void)validateParams:(NSDictionary *)params {
	NSAssert(params[ParamCompanyIDInt], @"you must pass a company ID parameter!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.contentView correctFonts];
	
	self.company = [DataManager objectOfType:DataTypeCompany withID:self.params[ParamCompanyIDInt]];
	self.friends = [self.company.friends allObjects];
	self.jobs = [self.company.jobs allObjects];
	self.similarCompanies = self.company.similarCompanies;
	self.navigationItem.title = self.company.name;
	
	[self.companyNameLabel setTextPreservingExistingAttributes:self.company.name];
	[self.companyDescriptionTextView setTextPreservingExistingAttributes:self.company.info];
	self.backgroundImageView.image = self.company.image;
	[self.followButton setTitle:[NSString stringWithFormat:@"follow %@", self.company.name] forState:UIControlStateNormal];
	
	if (self.company.following.boolValue) {
		[self.followButton setTitle:@"followed" forState:UIControlStateNormal];
		self.followButton.enabled = NO;
	}
	
	[self.scrollView addSubview:self.contentView];
	self.scrollView.contentSize = self.contentView.bounds.size;

	[self.friendsCollectionView registerNib:[UINib nibWithNibName:@"FriendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:FriendCellID];
	[self.jobsCollectionView registerNib:[UINib nibWithNibName:@"JobCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:JobCellID];
	[self.similarCompaniesCollectionView registerNib:[UINib nibWithNibName:@"CompanyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CompanyCellID];
	
	[self.scrollView addConstraints:@[@"|[_contentView]|", @"V:|[_contentView]|"] views:NSDictionaryOfVariableBindings(_contentView)];
	[self.view layoutIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (IBAction)followButtonPressed:(id)sender {
	[UIAlertView showAlertWithTitle:@"Followed" message:[NSString stringWithFormat:@"You are now following %@.", self.company.name] cancelButtonTitle:@"Done"];
	self.company.following = @(YES);
	[self.followButton setTitle:@"followed" forState:UIControlStateNormal];
	self.followButton.enabled = NO;
}


#pragma mark - Collection Views

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (collectionView == self.friendsCollectionView) {
		return self.friends.count;
	} else if (collectionView == self.jobsCollectionView) {
		return self.jobs.count;
	} else {
		return self.similarCompanies.count;
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView == self.friendsCollectionView) {
		FriendCollectionViewCell *cell = (FriendCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:FriendCellID forIndexPath:indexPath];
		cell.friend = self.friends[indexPath.row];
		return cell;
	} else if (collectionView == self.jobsCollectionView) {
		JobCollectionViewCell *cell = (JobCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:JobCellID forIndexPath:indexPath];
		cell.job = self.jobs[indexPath.row];
		return cell;
	} else {
		CompanyCollectionViewCell *cell = (CompanyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CompanyCellID forIndexPath:indexPath];
		cell.company = self.similarCompanies[indexPath.row];
		return cell;
	}
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView == self.friendsCollectionView) {
		return;
	} else if (collectionView == self.jobsCollectionView) {
		Job *j = self.jobs[indexPath.row];
		[NavigationService navigateTo:@"JobDetailViewController" params:@{ParamJobIDInt: j.id}];
	} else if (collectionView == self.similarCompaniesCollectionView) {
		Company *c = self.similarCompanies[indexPath.row];
		[NavigationService navigateTo:@"CompanyDetailViewController" params:@{ParamCompanyIDInt: c.id}];
	}
}


@end
