//
//  JobCardViewController.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Job.h"

@protocol JobCardViewControllerDelegate;


@interface JobCardViewController : UIViewController
PROP_DELEGATE(JobCardViewControllerDelegate);
PROP_STRONG Job *job;
@end


@protocol JobCardViewControllerDelegate <NSObject>
/// the job card is itself one giant button. Make yourself delegate of the job card to get a message when it is pressed.
- (void)jobCardViewControllerButtonPressed:(JobCardViewController *)jobCardViewController;
@end
