//
//  FunnelNavigationController.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

/// User onboarding/funnel.
/// 1. User name
/// 2. Location
/// 3. dream job
/// 4. salary
/// 5. experience
/// 6. done

typedef enum : int {
	FunnelNavigationControllerFlagCancelled = 1,
	FunnelNavigationControllerFlagFinished = 2
} FunnelNavigationControllerFlag;

#import "RaiseNavigationController.h"

@interface FunnelNavigationController : RaiseNavigationController

@end
