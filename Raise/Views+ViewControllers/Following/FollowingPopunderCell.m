//
//  FollowingPopunderCell.m
//  Raise
//
//  Created by Cameron Saul on 7/11/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FollowingPopunderCell.h"
#import "DataManager.h"

@interface FollowingPopunderCell ()
@property (strong, nonatomic) IBOutlet UIImageView *companyImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *employeeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *industryLabel;
@end

@implementation FollowingPopunderCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.contentView correctFonts];
}

- (void)setCompany:(Company *)company {
	_company = company;
	self.companyImageView.image = company.image;
	[self.nameLabel setTextPreservingExistingAttributes:company.name];
	[self.locationLabel setTextPreservingExistingAttributes:company.location.name];
	[self.employeeCountLabel setTextPreservingExistingAttributes:company.numberOfEmployees.description];
	[self.industryLabel setTextPreservingExistingAttributes:[company.industries.allObjects.firstObject name]];
}

@end
