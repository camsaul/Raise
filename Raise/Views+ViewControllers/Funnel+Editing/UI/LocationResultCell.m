//
//  LocationResultCell.m
//  Raise
//
//  Created by Cameron Saul on 7/11/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "LocationResultCell.h"

@interface LocationResultCell ()
@property (strong, nonatomic) IBOutlet UIImageView *checkImageView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@end

@implementation LocationResultCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.contentView correctFonts];
}

- (void)setChecked:(BOOL)checked {
	_checked = checked;
	if (checked) {
	}
	self.checkImageView.image = checked ? [UIImage imageNamed:@"button_check_80.png"] : [UIImage imageNamed:@"button_close_80.png"];
}

- (void)setLocationName:(NSString *)locationName {
	_locationName = locationName;
	[self.label setTextPreservingExistingAttributes:locationName];
}

@end
