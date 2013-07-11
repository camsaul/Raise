//
//  Job.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Job.h"
#import "Company.h"
#import "JobCategory.h"
#import "DataManager.h"

@implementation Job

@dynamic experience;
@dynamic info;
@dynamic salary;
@dynamic title;
@dynamic id;
@dynamic company;
@dynamic category;
@synthesize saved = _saved;

- (NSArray *)similarJobs {
	return [DataManager objectsOfType:DataTypeJob withPredicate:[NSPredicate predicateWithFormat:@"ALL category IN %@", self.category]];
}

@end
