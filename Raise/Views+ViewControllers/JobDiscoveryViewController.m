//
//  JobDiscoveryViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "JobDiscoveryViewController.h"

static const CGFloat PanCompleteThreshold = 50.0;

@interface JobDiscoveryViewController ()
PROP_STRONG IBOutlet UIImageView *jobCardImageView;
@property (strong, nonatomic) IBOutlet UIButton *noButton;
@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
PROP_STRONG UIPanGestureRecognizer *gestureRecognizer;
PROP CGRect originialJobCardFrame;
PROP CGPoint originalJobCardCenter;
@end

@implementation JobDiscoveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor raiseBackgroundPattern];
	
	self.navigationItem.titleView = [UIImageView raiseNavBarLogoImageView];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	
	self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
	[self.jobCardImageView addGestureRecognizer:self.gestureRecognizer];
}

- (void)pan {
	if (self.gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		self.originalJobCardCenter = self.jobCardImageView.center;
		self.originialJobCardFrame = self.jobCardImageView.frame;
	} else if (self.gestureRecognizer.state == UIGestureRecognizerStateChanged) {
		CGPoint location = [self.gestureRecognizer locationInView:self.view];
		
		CGFloat xDelta = location.x - self.originalJobCardCenter.x;
		if (xDelta > 0) {
			[self panRight:xDelta/160.0];
		} else {
			[self panLeft:xDelta/-160.0];
		}
		
		self.jobCardImageView.centerX =  location.x;
		
	} else if (self.gestureRecognizer.state == UIGestureRecognizerStateEnded || self.gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
		CGPoint location = [self.gestureRecognizer locationInView:self.view];
		CGFloat xDelta = location.x - self.originalJobCardCenter.x;
		
		if (ABS(xDelta) > PanCompleteThreshold) {
			BOOL left = xDelta < 0;
			
			UIImageView *oldJobCard = self.jobCardImageView;
			[oldJobCard removeGestureRecognizer:self.gestureRecognizer];
			
			[self addNewJobCard];
			self.jobCardImageView.centerX += left ? 320 : -320;
			
			[UIView animateWithDuration:0.4 animations:^{
				oldJobCard.centerX = self.originalJobCardCenter.x - (left ? 320 : -320);
				self.jobCardImageView.center = self.originalJobCardCenter;
				
				self.noButton.alpha = 1.0;
				self.yesButton.alpha = 1.0;
				self.infoButton.alpha = 1.0;
			} completion:^(BOOL finished) {
				[oldJobCard removeFromSuperview];
				
				// TODO - Show the little "explanations" for the first time someone does it
				
				if (left) {
					[self noAction];
				} else {
					[self yesAction];
				}
			}];
			
		} else {
			[UIView animateWithDuration:0.4 animations:^{
				self.jobCardImageView.center = self.originalJobCardCenter;
				
				self.noButton.alpha = 1.0;
				self.yesButton.alpha = 1.0;
				self.infoButton.alpha = 1.0;
			}];
		}
	}
}

- (void)addNewJobCard {
	self.jobCardImageView = [[UIImageView alloc] initWithFrame:self.originialJobCardFrame];
	self.jobCardImageView.image = [UIImage imageNamed:@"job_card.png"];
	self.jobCardImageView.userInteractionEnabled = YES;
	[self.view addSubview:self.jobCardImageView];
	[self.jobCardImageView addGestureRecognizer:self.gestureRecognizer];
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
	[NavigationService navigateTo:@"JobDetailPivotViewController" params:@{ParamJobID: @(100)}];
}

@end
