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

@interface JobDiscoveryViewController () <JobCardViewControllerDelegate>
PROP_STRONG IBOutlet UIView *jobCardPlaceholderView; // for layout purposes only.
PROP_STRONG JobCardViewController *jobCard;
@property (strong, nonatomic) IBOutlet UIButton *noButton;
@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
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
	self.statusLabel.alpha = 0;
	
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
			oldJobCard.view.layer.zPosition = 50;
			
			[self addNewJobCard];
			CATransform3D transform = CATransform3DIdentity;
			transform.m34 = -1/500.0;
			transform = CATransform3DRotate(transform, (left? - M_PI : M_PI)/1.5, 0, 1, 0);
			transform = CATransform3DScale(transform, .01, .01, 1);
			self.jobCard.view.layer.transform = transform;
			[UIView apply3DTransform:CATransform3DIdentity toView:self.jobCard.view duration:0.4 completion:nil];
			
			transform = oldJobCard.view.layer.transform;
			UIView *button = left ? self.noButton : self.yesButton;
			transform = CATransform3DTranslate(transform, button.centerX - oldJobCard.view.centerX, button.centerY - oldJobCard.view.centerY, 0);
			transform = CATransform3DScale(transform, 0.01, 0.01, 1);
			[UIView apply3DTransform:transform toView:oldJobCard.view duration:0.4 completion:^{
				if (left) {
					[self noAction];
				} else {
					[self yesAction:oldJobCard.job];
				}

				[oldJobCard.view removeFromSuperview];
			}];
			[UIView animateWithDuration:0.4 animations:^{
				self.noButton.alpha = 1.0;
				self.yesButton.alpha = 1.0;
				self.infoButton.alpha = 1.0;
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
	[self.jobCard.view removeGestureRecognizer:self.gestureRecognizer];
	self.jobCard = nil;
	
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
	self.jobCard.view.layer.zPosition = 200;
	jobCard.job = job;
	jobCard.delegate = self;
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
	JobCardViewController *oldJobCard = self.jobCard;
	oldJobCard.view.layer.zPosition = 50;
	
	[self addNewJobCard];
	self.jobCard.view.layer.zPosition = 200;
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1/500.0;
	transform = CATransform3DRotate(transform, M_PI/1.5, 0, 1, 0);
	transform = CATransform3DScale(transform, .01, .01, 1);
	self.jobCard.view.layer.transform = transform;
	[UIView apply3DTransform:CATransform3DIdentity toView:self.jobCard.view duration:0.4 completion:nil];
	
	transform = oldJobCard.view.layer.transform;
	transform = CATransform3DTranslate(transform, self.noButton.centerX - oldJobCard.view.centerX, self.noButton.centerY - oldJobCard.view.centerY, 0);
	transform = CATransform3DScale(transform, 0.01, 0.01, 1);
	[UIView apply3DTransform:transform toView:oldJobCard.view duration:0.4 completion:^{
		[self noAction];
		[oldJobCard.view removeFromSuperview];
	}];
}

- (IBAction)yesButtonPressed:(id)sender {
	JobCardViewController *oldJobCard = self.jobCard;
	oldJobCard.view.layer.zPosition = 50;
	
	[self addNewJobCard];
	self.jobCard.view.layer.zPosition = 200;
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1/500.0;
	transform = CATransform3DRotate(transform, -M_PI/1.5, 0, 1, 0);
	transform = CATransform3DScale(transform, .01, .01, 1);
	self.jobCard.view.layer.transform = transform;
	[UIView apply3DTransform:CATransform3DIdentity toView:self.jobCard.view duration:0.4 completion:nil];

	transform = oldJobCard.view.layer.transform;
	transform = CATransform3DTranslate(transform, self.yesButton.centerX - oldJobCard.view.centerX, self.yesButton.centerY - oldJobCard.view.centerY, 0);
	transform = CATransform3DScale(transform, 0.01, 0.01, 1);
	[UIView apply3DTransform:transform toView:oldJobCard.view duration:0.4 completion:^{
		[self yesAction:oldJobCard.job];
		[oldJobCard.view removeFromSuperview];
	}];
}

- (IBAction)infoButtonPressed:(id)sender {
	[self infoAction];
}

- (void)noAction {
	self.statusLabel.text = @"not for me.";
	[UIView animateWithDuration:0.4 animations:^{
		self.statusLabel.alpha = 1;
	} completion:^(BOOL finished) {
		if (!finished) return;
		[UIView animateWithDuration:1.2 animations:^{
			self.statusLabel.alpha = 0;
		}];
	}];
}

- (void)yesAction:(Job *)job {
	self.statusLabel.text = @"saved.";
	job.saved = YES;
	[UIView animateWithDuration:0.4 animations:^{
		self.statusLabel.alpha = 1;
	} completion:^(BOOL finished) {
		if (!finished) return;
		[UIView animateWithDuration:1.2 animations:^{
			self.statusLabel.alpha = 0;
		}];
	}];
}

- (void)infoAction {
	[NavigationService navigateTo:@"JobDetailViewController" params:@{ParamJobIDInt: self.jobID}];
}


#pragma mark - job card delegate 

- (void)jobCardViewControllerButtonPressed:(JobCardViewController *)jobCardViewController {
	[self infoAction];
}

@end
