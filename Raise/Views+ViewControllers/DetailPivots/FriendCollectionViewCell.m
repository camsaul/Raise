//
//  FriendCollectionViewCell.m
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "FriendCollectionViewCell.h"

@interface FriendCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *labelsView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@end

@implementation FriendCollectionViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.labelsView correctFonts];
}

- (void)setFriend:(Friend *)friend {
	_friend = friend;
	[self.nameLabel setTextPreservingExistingAttributes:friend.name];
	[self.positionLabel setTextPreservingExistingAttributes:friend.position];
	self.imageView.image = friend.image;
}

@end
