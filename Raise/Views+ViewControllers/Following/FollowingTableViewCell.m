//
//  FollowingTableViewCell.m
//  Raise
//
//  Created by Cameron Saul on 7/11/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingTableViewCell.h"

@interface FollowingTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *labelsView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsLabel;

@end

@implementation FollowingTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.labelsView correctFonts];
}

- (void)setCompany:(Company *)company {
	_company = company;
	[self.nameLabel setTextPreservingExistingAttributes:company.name];
	[self.jobsLabel setTextPreservingExistingAttributes:[NSString stringWithFormat:@"%d Jobs", company.jobs.count]];
	self.backgroundImageView.image = company.image;
}

@end
