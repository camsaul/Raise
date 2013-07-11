//
//  Company.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
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
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *industries;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSSet *jobs;

PROP BOOL following;
/// sort of expensive -- does CoreData query -- so you should cache it
- (NSArray *)similarCompanies;
- (UIImage *)image;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)insertObject:(Friend *)value inFriendsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFriendsAtIndex:(NSUInteger)idx;
- (void)insertFriends:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFriendsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFriendsAtIndex:(NSUInteger)idx withObject:(Friend *)value;
- (void)replaceFriendsAtIndexes:(NSIndexSet *)indexes withFriends:(NSArray *)values;
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
