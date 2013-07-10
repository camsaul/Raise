//
//  DataImporter.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "DataImporter.h"
#import "CHCSVParser.h"
#import "Company.h"
#import "Location.h"
#import "Job.h"
#import "Industry.h"
#import "JobCategory.h"
#import "Friend.h"

typedef void(^ParseBlock)(NSNumber *ID, NSArray *values);

@implementation DataImporter

#pragma mark - Helper Methods

+ (NSArray *)parseCSVFile:(NSString *)file {
	return [NSArray arrayWithContentsOfCSVFile:[[NSBundle mainBundle] pathForResource:file ofType:@"csv"] options:CHCSVParserOptionsSanitizesFields];
}

+ (void)parseCSVFile:(NSString *)file withBlock:(ParseBlock)block {
	NSArray *a = [self parseCSVFile:file];
	int count = a.count;
	for (int i = 1; i < count; i++) {
		NSArray *values = a[i];
		int ID = [values[0] intValue];
		block(@(ID), values);
	}
}

+ (id)newObjectOfType:(NSString *)type ID:(NSNumber *)ID {
	id obj = [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:APP_DELEGATE.managedObjectContext];
	[obj setId:ID];
	return obj;
}

+ (id)objectOfType:(NSString *)type withID:(NSNumber *)ID {
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:type];
	request.predicate = [NSPredicate predicateWithFormat:@"id=%@", ID];
	NSError *error = nil;
	NSArray *results = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		BKLog(LogFlagError, LogCategoryEtc, @"data importer error:%@, type: %@, id: %@", error, type, ID);
		return nil;
	}
	if (!results.count) {
		BKLog(LogFlagWarn, LogCategoryEtc, @"warning: no object found for type: %@, id: %@", type, ID);
		return nil;
	}
	return results[0];
}

+ (NSSet *)objectsOfType:(NSString *)type withIDs:(NSString *)IDsStr {
	NSMutableSet *mA = [NSMutableSet set];
	for (NSString *IDstr in [IDsStr componentsSeparatedByString:@","]) {
		NSNumber *IDnum = @([IDstr intValue]);
		id obj = [self objectOfType:type withID:IDnum];
		if (obj) {
			[mA addObject:obj];
		}
	}
	return mA;
}


#pragma mark - Parsing Code

+ (void)importData {
	[self importLocations];		// done
	[self importJobCategories]; // done
	[self importIndustryCodes];	// done
	[self importFriends];		// done
	[self importCompanies];
	[self importJobs];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Job"];
	NSError *error = nil;
	NSArray *results = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&error];
	NSLog(@"results: %@", results);
}

+ (void)importLocations {
	[self parseCSVFile:@"locations" withBlock:^(NSNumber *ID, NSArray *values) {
		Location *l = [self newObjectOfType:@"Location" ID:ID];
		l.name = values[1];
		l.lat = @([values[2] floatValue]);
		l.lon = @([values[3] floatValue]);
	}];
}

+ (void)importJobCategories {
	[self parseCSVFile:@"job_categories" withBlock:^(NSNumber *ID, NSArray *values) {
		JobCategory *jc = [self newObjectOfType:@"JobCategory" ID:ID];
		jc.name = values[1];
	}];	
}

+ (void)importIndustryCodes {
	[self parseCSVFile:@"industry_codes" withBlock:^(NSNumber *ID, NSArray *values) {
		Industry *i = [self newObjectOfType:@"Industry" ID:ID];
		i.name = values[1];
	}];
}

+ (void)importFriends {
	[self parseCSVFile:@"friends" withBlock:^(NSNumber *ID, NSArray *values) {
		Friend *f = [self newObjectOfType:@"Friend" ID:ID];
		f.name = values[1];
	}];
}

+ (void)importCompanies {
	[self parseCSVFile:@"companies" withBlock:^(NSNumber *ID, NSArray *values) {
		Company *c = [self newObjectOfType:@"Company" ID:ID];
		c.name = values[1];
		c.location = [self objectOfType:@"Location" withID:@([values[2] intValue])];
		c.numberOfEmployees = @([values[3] intValue]);
		[c addIndustries:[self objectsOfType:@"Industry" withIDs:values[4]]];
		c.info = values[5];
		[c addFriends:[self objectsOfType:@"Friend" withIDs:values[6]]];
	}];
}

// id,company,title,salary,experience,job_category,description,skills,link
+ (void)importJobs {
	[self parseCSVFile:@"jobs" withBlock:^(NSNumber *ID, NSArray *values) {
		Job *j = [self newObjectOfType:@"Job" ID:ID];
		j.company = [self objectOfType:@"Company" withID:@([values[1] integerValue])];
		j.title = values[2];
		j.salary = @([values[3] intValue]);
		j.experience = @([values[4] intValue]);
		[j addCategory:[self objectsOfType:@"JobCategory" withIDs:values[5]]];
		j.info = values[6];
	}];
}


@end
