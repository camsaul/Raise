//
//  FriendCollectionViewCell.h
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Friend.h"

static NSString *FriendCellID = @"FriendCell";

@interface FriendCollectionViewCell : UICollectionViewCell

PROP_STRONG Friend *friend;

@end
