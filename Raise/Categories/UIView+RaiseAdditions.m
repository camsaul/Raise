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
	for (id subview in self.subviews) {
		if (!([subview isKindOfClass:[UILabel class]] ||
			  [subview isKindOfClass:[UITextView class]])) continue;
		
		BOOL isBold = [[subview font].fontName containsString:@"Bold"];
		BOOL isItalic = [[subview font].fontName containsString:@"Italic"];
		NSString *fontName;
		if (isBold || isItalic) {
			fontName = [NSString stringWithFormat:@"Cabin-%@%@", (isBold ? @"Bold" : @""), (isItalic ? @"Italic" : @"")];
		} else {
			fontName = @"Cabin-Regular";
		}

		CGFloat size = [subview font].pointSize;

		[subview setFont:[UIFont fontWithName:fontName size:size]];
	}
}

@end
