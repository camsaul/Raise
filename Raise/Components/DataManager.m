//
//  DataManager.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (NSString *)stringForDataType:(DataType)type {
	switch (type) {
		case DataTypeCompany:		return @"Company";
		case DataTypeLocation:		return @"Location";
		case DataTypeIndustry:		return @"Industry";
		case DataTypeJobCategory:	return @"JobCategory";
		case DataTypeFriend:		return @"Friend";
		case DataTypeJob:			return @"Job";
	}
	NSAssert(NO, @"invalid enum: %d", type);
	return nil;
}

+ (id)createObjectOfType:(DataType)type ID:(NSNumber *)ID {
	id obj = [NSEntityDescription insertNewObjectForEntityForName:[self stringForDataType:type] inManagedObjectContext:APP_DELEGATE.managedObjectContext];
	[obj setId:ID];
	return obj;
}

+ (id)objectOfType:(DataType)type withID:(id)ID {
	ID = @([ID intValue]); // this will convert any NSStrings to numbers without affecting NSNumbers
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self stringForDataType:type]];
	request.predicate = [NSPredicate predicateWithFormat:@"id=%@", ID];
	NSError *error = nil;
	NSArray *results = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		BKLog(LogFlagError, LogCategoryEtc, @"data manager error:%@, type: %@, id: %@", error, [self stringForDataType:type], ID);
		return nil;
	}
	if (!results.count) {
		BKLog(LogFlagWarn, LogCategoryEtc, @"data manager warning: no object found for type: %@, id: %@", [self stringForDataType:type], ID);
		return nil;
	}
	return results[0];
}

+ (NSSet *)objectsOfType:(DataType)type withIDs:(NSArray *)IDnumbersOrStrings {
	NSMutableSet *mA = [NSMutableSet set];
	for (id idObj in IDnumbersOrStrings) {
		NSNumber *IDnum = @([idObj intValue]); // NSNumber or NSString will both respond to this, so no problems 
		id obj = [self objectOfType:type withID:IDnum];
		if (obj) {
			[mA addObject:obj];
		}
	}
	return mA;
}

+ (NSArray *)objectsOfType:(DataType)type withPredicate:(NSPredicate *)predicate {
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self stringForDataType:type]];
	request.predicate = predicate;
	NSError *error = nil;
	NSArray *results = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		BKLog(LogFlagError, LogCategoryEtc, @"data manager error:%@, type: %@, predicate: %@", error, [self stringForDataType:type], predicate);
		return nil;
	}
	if (!results.count) {
		BKLog(LogFlagWarn, LogCategoryEtc, @"data manager warning: no objects found for type: %@, predicate: %@", [self stringForDataType:type], predicate);
		return nil;
	}
	return results;
}

+ (NSArray *)allObjectsOfType:(DataType)type {
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self stringForDataType:type]];
	NSError *error = nil;
	NSArray *results = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		BKLog(LogFlagError, LogCategoryEtc, @"data manager error:%@, type: %@", error, [self stringForDataType:type]);
		return nil;
	}
	if (!results.count) {
		BKLog(LogFlagWarn, LogCategoryEtc, @"data manager warning: no objects found for type: %@", [self stringForDataType:type]);
		return nil;
	}
	
	return results;
}

@end
