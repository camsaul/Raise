//
//  UIView+RaiseAdditions.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "UIView+RaiseAdditions.h"

@implementation UIView (RaiseAdditions)

- (void)correctFonts {
	// loop over all the labels and correct the font
	for (UILabel *label in self.subviews) {
		if (![label isKindOfClass:[UILabel class]]) continue;
		
		BOOL isBold = [label.font.fontName containsString:@"Bold"];
		BOOL isItalic = [label.font.fontName containsString:@"Italic"];
		NSString *fontName;
		if (isBold || isItalic) {
			fontName = [NSString stringWithFormat:@"Cabin-%@%@", (isBold ? @"Bold" : @""), (isItalic ? @"Italic" : @"")];
		} else {
			fontName = @"Cabin-Regular";
		}

		CGFloat size = label.font.pointSize;

		label.font = [UIFont fontWithName:fontName size:size];
	}
}

@end
