//
//  JobDetailViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDetailViewController.h"
#import "JobCollectionViewCell.h"
#import "DataManager.h"

@interface JobDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

PROP_STRONG Job *job;
PROP_STRONG NSArray *similarJobs;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *jobDescriptionTextView;

@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *companyDescriptionTextView;

@property (strong, nonatomic) IBOutlet UIButton *applyNowButton;
@property (strong, nonatomic) IBOutlet UIButton *sendToAFriendButton;
@property (strong, nonatomic) IBOutlet UIButton *saveForLaterButton;
@property (strong, nonatomic) IBOutlet UIButton *companyFollowButton;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UICollectionView *similarJobsCollectionView;

@end

@implementation JobDetailViewController

+ (void)validateParams:(NSDictionary *)params {
	NSAssert(params[ParamJobIDInt], @"please pass a Job ID!");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.contentView correctFonts];
	
	Job *job = [DataManager objectOfType:DataTypeJob withID:self.params[ParamJobIDInt]];
	self.job = job;
	self.similarJobs = job.similarJobs;
	
	self.navigationItem.title = job.title;
	self.backgroundImageView.image = job.company.image;
	
	[self.jobTitleLabel setTextPreservingExistingAttributes:job.title];
	[self.jobDescriptionTextView setTextPreservingExistingAttributes:job.info];
	
	[self.companyNameLabel setTextPreservingExistingAttributes:job.company.name];
	[self.companyDescriptionTextView setTextPreservingExistingAttributes:job.company.info];
	[self.companyFollowButton setTitle:[NSString stringWithFormat:@"follow %@", self.job.company.name] forState:UIControlStateNormal];
	
	[self.locationLabel setTextPreservingExistingAttributes:job.company.location.name];
	[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(job.company.location.coordinate, 10000, 10000) animated:YES];
	[self.mapView addAnnotation:job.company.location.annotation];
	
	[self.scrollView addSubview:self.contentView];
	self.scrollView.contentSize = self.contentView.bounds.size;
	
	[self.similarJobsCollectionView registerNib:[UINib nibWithNibName:@"JobCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:JobCellID];
	self.similarJobsCollectionView.backgroundColor = [UIColor clearColor];
	
	if (job.saved) {
		[self.saveForLaterButton setTitle:@"saved" forState:UIControlStateNormal];
		self.saveForLaterButton.enabled = NO;
	}
	if (job.company.following.boolValue) {
		[self.companyFollowButton setTitle:@"followed" forState:UIControlStateNormal];
		self.companyFollowButton.enabled = NO;
	}
	
	[self.scrollView addConstraints:@[@"|[_contentView]|", @"V:|[_contentView]|"] views:NSDictionaryOfVariableBindings(_contentView)];
	[self.view layoutIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (IBAction)companyInfoButtonPressed:(id)sender {
	[NavigationService navigateTo:@"CompanyDetailViewController" params:@{ParamCompanyIDInt: self.job.company.id}];
}

- (IBAction)saveForLaterButtonPressed:(id)sender {
	[RaiseAlertView showAlertWithTitle:@"Saved" message:[NSString stringWithFormat:@"%@ at %@ has been saved for later.", self.job.title, self.job.company.name] cancelButtonTitle:@"Done"];
	self.job.saved = YES;
	[self.saveForLaterButton setTitle:@"saved" forState:UIControlStateNormal];
	self.saveForLaterButton.enabled = NO;
}

- (IBAction)sendToAFriendButtonPressed:(id)sender {
	[RaiseAlertView showAlertWithTitle:@"Coming Soon" message:@"This feature isn't finished just jet. But when it's done, you'll be able to send a job to a friend via email, text, tweet, or with a Facebook or LinkedIn message." cancelButtonTitle:@"Done"];
}

- (IBAction)applyNowButtonPressed:(id)sender {
	[RaiseAlertView showAlertWithTitle:@"Apply?" message:@"Would you like to use one of your One-Tap Job Apps™ to apply for this job?" buttonPressedBlock:^(BOOL cancelButtonPressed, NSUInteger buttonIndex) {
		if (!cancelButtonPressed) {
			[RaiseAlertView showAlertWithTitle:@"Success" message:[NSString stringWithFormat:@"You have successfully applied to be a %@ at %@.", self.job.title, self.job.company.name]
						  cancelButtonTitle:@"Done"];
		}
	} cancelButtonTitle:@"Not Now" otherButtonTitles:@"Sure!", nil];
}

- (IBAction)companyFollowButtonPressed:(id)sender {
	[RaiseAlertView showAlertWithTitle:@"Followed" message:[NSString stringWithFormat:@"You are now following %@.", self.job.company.name] cancelButtonTitle:@"Done"];
	self.job.company.following = @(YES);
	[self.companyFollowButton setTitle:@"followed" forState:UIControlStateNormal];
	self.companyFollowButton.enabled = NO;
}

- (IBAction)openInMapsButtonPressed:(id)sender {
	MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.job.company.location.coordinate addressDictionary:nil]];
	mapItem.name = self.job.company.name;
	[MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
}


#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.similarJobs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	JobCollectionViewCell *cell = (JobCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:JobCellID forIndexPath:indexPath];
	cell.job = self.similarJobs[indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	Job *j = self.similarJobs[indexPath.row];
	[NavigationService navigateTo:@"JobDetailViewController" params:@{ParamJobIDInt: j.id}];
}

@end
