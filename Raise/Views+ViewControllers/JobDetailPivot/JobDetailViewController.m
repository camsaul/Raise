//
//  JobDetailViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDetailViewController.h"

#import "JobOverviewPivotCompanyPage.h"

typedef enum : NSUInteger {
	JobDetailPageOverview,
	JobDetailPageCompany,
	JobDetailPageLocation,
	JobDetailPageSimilar
} JobDetailPage;

@interface JobDetailViewController () <BKPivotViewControllerDelegate>
PROP_STRONG BKPivotViewController *pivot;

PROP_STRONG JobOverviewPivotCompanyPage *companyPage;

@end

@implementation JobDetailViewController

+ (void)validateParams:(NSDictionary *)params {
	NSAssert(params[ParamJobID], @"you must pass a job ID to JobDetailViewController!");
}

- (void)loadView {
	self.view = [[UIView alloc] init];
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	BKPivotViewController *pivot = [[BKPivotViewController alloc] init];
	self.pivot = pivot;
	self.pivot.delegate = self;
	pivot.view.backgroundColor = [UIColor clearColor];
	
	self.pivot.view.frame = self.view.bounds;
	self.pivot.view.autoresizingMask = UIViewAutoresizingFlexibleSize;	
	[self.view addSubview:self.pivot.view];
}

- (JobOverviewPivotCompanyPage *)companyPage {
	if (!_companyPage) {
		_companyPage = [[JobOverviewPivotCompanyPage alloc] initWithParams:self.params];
	}
	return _companyPage;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_navbar.png"]];
}



#pragma mark - BKPivotViewControllerDelegate

- (NSUInteger)pivotViewNumberOfPages {
	return 1;
}

- (UIView *)pivotViewControllerViewForPageAtIndex:(JobDetailPage)index pageSpan:(NSUInteger *)pageSpan {
	switch (index) {
		default: return self.companyPage.view;
//		case JobDetailPageOverview: return self.overviewPage;
//		case JobDetailPageCompany: return self.companyPage;
//		case JobDetailPageLocation: return self.locationPage;
//		case JobDetailPageSimilar: return self.similarJobsPage;
	}
}


@end
