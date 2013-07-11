//
//  CompanyCollectionViewCell.m
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "CompanyCollectionViewCell.h"
#import "DataManager.h"

@interface CompanyCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *labelsView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation CompanyCollectionViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.labelsView correctFonts];
}

- (void)setCompany:(Company *)company {
	_company = company;
	self.imageView.image = company.image;
	[self.nameLabel setTextPreservingExistingAttributes:company.name];
	[self.locationLabel setTextPreservingExistingAttributes:company.location.name];
}

@end
