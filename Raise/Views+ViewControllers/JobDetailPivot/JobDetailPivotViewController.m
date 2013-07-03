//
//  JobDetailViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDetailPivotViewController.h"

#import "JobDetailPivotOverviewPage.h"
#import "JobDetailPivotCompanyPage.h"
#import "JobDetailPivotLocationPage.h"
#import "JobDetailPivotSimilarPage.h"

typedef enum : NSUInteger {
	JobDetailPageOverview,
	JobDetailPageCompany,
	JobDetailPageLocation,
	JobDetailPageSimilar
} JobDetailPage;

@interface JobDetailPivotViewController () <BKPivotViewControllerDelegate>
PROP_STRONG BKPivotViewController *pivot;
PROP_STRONG UIImageView *backgroundImageView;

PROP_STRONG JobDetailPivotOverviewPage *overviewPage;
PROP_STRONG JobDetailPivotCompanyPage *companyPage;
PROP_STRONG JobDetailPivotLocationPage *locationPage;
PROP_STRONG JobDetailPivotSimilarPage *similarJobsPage;

@end

@implementation JobDetailPivotViewController

+ (void)validateParams:(NSDictionary *)params {
	NSAssert(params[ParamJobID], @"you must pass a job ID to JobDetailViewController!");
}

- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	
	self.view.backgroundColor = [UIColor blackColor];
	self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fake_facebook_background.png"]];
	self.backgroundImageView.frame = self.view.bounds;
	self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleSize;
	self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
	self.backgroundImageView.alpha = 0.3f;
	[self.view addSubview:self.backgroundImageView];
	
	BKPivotViewController *pivot = [[BKPivotViewController alloc] init];
	self.pivot = pivot;
	self.pivot.delegate = self;
	pivot.view.backgroundColor = [UIColor clearColor];
	
	self.pivot.view.frame = self.view.bounds;
	self.pivot.view.autoresizingMask = UIViewAutoresizingFlexibleSize;	
	[self.view addSubview:self.pivot.view];
}

- (JobDetailPivotOverviewPage *)overviewPage {
	if (!_overviewPage) {
		_overviewPage = [[JobDetailPivotOverviewPage alloc] initWithParams:self.params];
	}
	return _overviewPage;
}

- (JobDetailPivotCompanyPage *)companyPage {
	if (!_companyPage) {
		_companyPage = [[JobDetailPivotCompanyPage alloc] initWithParams:self.params];
	}
	return _companyPage;
}

- (JobDetailPivotLocationPage *)locationPage {
	if (!_locationPage) {
		_locationPage = [[JobDetailPivotLocationPage alloc] initWithParams:self.params];
	}
	return _locationPage;
}

- (JobDetailPivotSimilarPage *)similarJobsPage {
	if (!_similarJobsPage) {
		_similarJobsPage = [[JobDetailPivotSimilarPage alloc] initWithParams:self.params];
	}
	return _similarJobsPage;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
}



#pragma mark - BKPivotViewControllerDelegate

- (NSUInteger)pivotViewNumberOfPages {
	return 4;
}

- (UIView *)pivotViewControllerViewForPageAtIndex:(NSUInteger)index pageSpan:(NSUInteger *)pageSpan {
	switch (index) {
		case JobDetailPageOverview: return self.overviewPage.view;
		case JobDetailPageCompany: return self.companyPage.view;
		case JobDetailPageLocation: return self.locationPage.view;
		case JobDetailPageSimilar: return self.similarJobsPage.view;
	}
	NSAssert(NO, @"Invalid page!");
	return nil;
}


@end
