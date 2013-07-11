//
//  Company.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Company.h"
#import "Friend.h"
#import "Industry.h"
#import "Job.h"
#import "Location.h"
#import "DataManager.h"

@implementation Company

@dynamic id;
@dynamic info;
@dynamic name;
@dynamic numberOfEmployees;
@dynamic friends;
@dynamic industries;
@dynamic location;
@dynamic jobs;
@synthesize following;

- (UIImage *)image {
	UIImage *img = nil;
	
	img = [UIImage imageNamed:[NSString stringWithFormat:@"company_%@.jpg", self.id]];
	if (img) return img;
	
	img = [UIImage imageNamed:[NSString stringWithFormat:@"company_%@.png", self.id]];
	if (img) return img;
	
	img = [UIImage imageNamed:[NSString stringWithFormat:@"company_%@.jpeg", self.id]];
	return img;
}

- (NSArray *)similarCompanies {
	return [DataManager objectsOfType:DataTypeCompany withPredicate:[NSPredicate predicateWithFormat:@"ALL industries IN %@", self.industries]];
}

@end
