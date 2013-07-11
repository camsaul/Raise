//
//  CompanyCollectionViewCell.h
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Company.h"

static NSString *CompanyCellID = @"CompanyCell";

@interface CompanyCollectionViewCell : UICollectionViewCell

PROP_STRONG Company *company;

@end
