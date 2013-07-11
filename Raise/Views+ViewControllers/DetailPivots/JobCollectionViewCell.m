//
//  JobCollectionViewCell.m
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobCollectionViewCell.h"
#import "DataManager.h"

@interface JobCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *labelsView;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation JobCollectionViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.labelsView correctFonts];
}

- (void)setJob:(Job *)job {
	_job = job;
	self.imageView.image = job.company.image;
	[self.jobTitleLabel setTextPreservingExistingAttributes:job.title];
	[self.companyLabel setTextPreservingExistingAttributes:job.company.name];
	[self.locationLabel setTextPreservingExistingAttributes:job.company.location.name];
}


@end
