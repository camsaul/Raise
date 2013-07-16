//
//  SavedViewController.m
//  Raise
//
//  Created by Cameron Saul on 7/15/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "SavedViewController.h"
#import "JobCollectionViewCell.h"
#import "DataManager.h"

@interface SavedViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
PROP_STRONG NSArray *jobs;
@end

@implementation SavedViewController

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
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem raiseMenuBarButtonItem];
	[self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JobCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:JobCellID];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.jobs = [DataManager objectsOfType:DataTypeJob withPredicate:[NSPredicate predicateWithFormat:@"saved == TRUE"]];
	[self.collectionView reloadData];
}


#pragma mark - collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.jobs.count;
	
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	JobCollectionViewCell *cell = (JobCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:JobCellID forIndexPath:indexPath];
	cell.job = self.jobs[indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	Job *j = self.jobs[indexPath.row];
	[NavigationService navigateTo:@"JobDetailViewController" params:@{ParamJobIDInt: j.id}];
}

@end
