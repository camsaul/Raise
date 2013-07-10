//
//  JobCardViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobCardViewController.h"
#import "DataManager.h"

@interface JobCardViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *friendsLabel;
@property (strong, nonatomic) IBOutlet UILabel *salaryLabel;
@property (strong, nonatomic) IBOutlet UIView *infoView;

@end

@implementation JobCardViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.infoView correctFonts];
}

- (void)setJob:(Job *)job {
	_job = job;
	
	NSAssert(self.titleLabel, @"View isn't loaded yet. Do that first before setting job!");
	self.imageView.image = job.company.image;
	[self.titleLabel setTextPreservingExistingAttributes:job.title];
	[self.titleLabel sizeToFit];
	[self.companyLabel setTextPreservingExistingAttributes:job.company.name];
	[self.locationLabel setTextPreservingExistingAttributes:job.company.location.name];
	[self.friendsLabel setTextPreservingExistingAttributes:[NSString stringWithFormat:@"%d", job.company.friends.count]];
	[self.salaryLabel setTextPreservingExistingAttributes:[NSString stringWithFormat:@"%@k", job.salary]];
}

@end
