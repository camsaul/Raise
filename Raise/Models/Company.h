//
//  Company.h
//  Raise
//
//  Created by Cameron Saul on 7/11/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend, Industry, Job, Location;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numberOfEmployees;
@property (nonatomic, retain) NSNumber * following;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *industries;
@property (nonatomic, retain) NSSet *jobs;
@property (nonatomic, retain) Location *location;

- (UIImage *)image;
- (NSArray *)similarCompanies;

+ (NSArray *)followedCompanies;

@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addIndustriesObject:(Industry *)value;
- (void)removeIndustriesObject:(Industry *)value;
- (void)addIndustries:(NSSet *)values;
- (void)removeIndustries:(NSSet *)values;

- (void)addJobsObject:(Job *)value;
- (void)removeJobsObject:(Job *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

@end
