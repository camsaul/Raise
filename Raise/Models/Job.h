//
//  Job.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, JobCategory;

@interface Job : NSManagedObject

@property (nonatomic, retain) NSNumber * experience;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSSet *category;

PROP BOOL saved;
/// sort of expensive -- does CoreData query -- so you should cache it
- (NSArray *)similarJobs;

@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addCategoryObject:(JobCategory *)value;
- (void)removeCategoryObject:(JobCategory *)value;
- (void)addCategory:(NSSet *)values;
- (void)removeCategory:(NSSet *)values;

@end
