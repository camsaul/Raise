//
//  JobDiscoveryViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDiscoveryViewController.h"
#import "JobCardViewController.h"
#import "DataManager.h"

static const CGFloat PanCompleteThreshold = 50.0;

@interface JobDiscoveryViewController ()
PROP_STRONG IBOutlet UIView *jobCardPlaceholderView; // for layout purposes only.
PROP_STRONG JobCardViewController *jobCard;
@property (strong, nonatomic) IBOutlet UIButton *noButton;
@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
PROP_STRONG UIPanGestureRecognizer *gestureRecognizer;
PROP_STRONG NSNumber *jobID;
@end

@implementation JobDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
	self.jobCardPlaceholderView.alpha = 0;
	
	dispatch_next_run_loop(^{
		[self addNewJobCard];
	});
}

- (void)pan {
	if (self.gestureRecognizer.state == UIGestureRecognizerStateBegan) {
	} else if (self.gestureRecognizer.state == UIGestureRecognizerStateChanged) {
		CGPoint location = [self.gestureRecognizer locationInView:self.view];
		
		CGFloat xDelta = location.x - self.jobCardPlaceholderView.centerX;
		if (xDelta > 0) {
			[self panRight:xDelta/160.0];
		} else {
			[self panLeft:xDelta/-160.0];
		}
		
		self.jobCard.view.centerX =  location.x;
		
	} else if (self.gestureRecognizer.state == UIGestureRecognizerStateEnded || self.gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
		CGPoint location = [self.gestureRecognizer locationInView:self.view];
		CGFloat xDelta = location.x - self.jobCardPlaceholderView.centerX;
		
		if (ABS(xDelta) > PanCompleteThreshold) {
			BOOL left = xDelta < 0;
			
			JobCardViewController *oldJobCard = self.jobCard;
			self.jobCard = nil;
			[oldJobCard.view removeGestureRecognizer:self.gestureRecognizer];
			[self addNewJobCard];
			
			self.jobCard.view.centerX += left ? 320 : -320;
			
			[UIView animateWithDuration:0.4 animations:^{
				oldJobCard.view.centerX = self.jobCardPlaceholderView.centerX - (left ? 320 : -320);
				self.jobCard.view.center = self.jobCardPlaceholderView.center;
				
				self.noButton.alpha = 1.0;
				self.yesButton.alpha = 1.0;
				self.infoButton.alpha = 1.0;
			} completion:^(BOOL finished) {
				[oldJobCard.view removeFromSuperview];
				
				// TODO - Show the little "explanations" for the first time someone does it
				
				if (left) {
					[self noAction];
				} else {
					[self yesAction];
				}
			}];
			
		} else {
			[UIView animateWithDuration:0.4 animations:^{
				self.jobCard.view.center = self.jobCardPlaceholderView.center;
				
				self.noButton.alpha = 1.0;
				self.yesButton.alpha = 1.0;
				self.infoButton.alpha = 1.0;
			}];
		}
	}
}

- (void)addNewJobCard {
	// select a random job
	NSArray *allJobs = [DataManager allObjectsOfType:DataTypeJob];
	Job *job = allJobs[rand() % allJobs.count];
	self.jobID = job.id;
	
	JobCardViewController *jobCard = [[JobCardViewController alloc] init];
	jobCard.view.frame = self.jobCardPlaceholderView.frame;
	jobCard.view.userInteractionEnabled = YES;

	[self.view addSubview:jobCard.view];
	[jobCard.view addGestureRecognizer:self.gestureRecognizer];
	self.jobCard = jobCard;
	jobCard.job = job;
}

- (void)panLeft:(CGFloat)amount {
	self.yesButton.alpha = 1 - amount;
	self.infoButton.alpha = 1 - amount;
}

- (void)panRight:(CGFloat)amount {
	self.noButton.alpha = 1 - amount;
	self.infoButton.alpha = 1 - amount;
}

- (IBAction)noButtonPressed:(id)sender {
	[self noAction];
}

- (IBAction)yesButtonPressed:(id)sender {
	[self yesAction];
}

- (IBAction)infoButtonPressed:(id)sender {
	[self infoAction];
}

- (void)noAction {
	TODO_ALERT(@"mark this job as wack and show the next job");
}

- (void)yesAction {
	TODO_ALERT(@"save this job as a favorite and show the next job!");
}

- (void)infoAction {
	[NavigationService navigateTo:@"JobDetailViewController" params:@{ParamJobIDInt: self.jobID}];
}

@end
