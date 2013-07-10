//
//  DataManager.h
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Company.h"
#import "Location.h"
#import "Job.h"
#import "Industry.h"
#import "JobCategory.h"
#import "Friend.h"

typedef enum : int {
	DataTypeCompany,
	DataTypeLocation,
	DataTypeIndustry,
	DataTypeJobCategory,
	DataTypeFriend,
	DataTypeJob
} DataType;

/// easy interface to various models from the managed object context

@interface DataManager : NSObject

+ (id)createObjectOfType:(DataType)type ID:(NSNumber *)ID;

+ (id)objectOfType:(DataType)type withID:(id)idNumberOrString;
+ (NSSet *)objectsOfType:(DataType)type withIDs:(NSArray *)IDnumbersOrStrings;
+ (NSArray *)allObjectsOfType:(DataType)type;

@end
