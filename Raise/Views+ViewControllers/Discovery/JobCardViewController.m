//
//  JobCardViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobCardViewController.h"

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
	self.titleLabel.text = job.title;
}

@end
