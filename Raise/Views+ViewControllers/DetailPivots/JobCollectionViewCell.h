//
//  JobCollectionViewCell.h
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Job.h"

static NSString *JobCellID = @"JobCell";

@interface JobCollectionViewCell : UICollectionViewCell

PROP_STRONG Job *job;

@end
