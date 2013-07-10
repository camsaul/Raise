//
//  FunnelGaugeView.h
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAnnotatedGauge.h"

@protocol FunnelGaugeViewDelegate;


@interface FunnelGaugeView : UIView

PROP_DELEGATE(FunnelGaugeViewDelegate);

PROP_STRONG_RO UILabel *titleLabel;
PROP_STRONG_RO UIButton *continueButton;

PROP_STRONG_RO MSSimpleGauge *gauge;
PROP_STRONG_RO UILabel *valueLabel;
PROP_STRONG_RO UILabel *minValueLabel;
PROP_STRONG_RO UILabel *maxValueLabel;

@end


@protocol FunnelGaugeViewDelegate <NSObject>
- (NSString *)funnelGaugeViewStringForValue:(float)value;
@end