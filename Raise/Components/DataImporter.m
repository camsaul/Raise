//
//  DataImporter.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "DataImporter.h"
#import "CHCSVParser.h"
#import "DataManager.h"

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


#pragma mark - Parsing Code

+ (void)importData {
	[self importLocations];		// done
	[self importJobCategories]; // done
	[self importIndustryCodes];	// done
	[self importFriends];		// done
	[self importCompanies];
	[self importJobs];
	
	BKLog(LogFlagInfo, LogCategoryEtc, @"DataImporter Finished.");
}

+ (void)importLocations {
	[self parseCSVFile:@"locations" withBlock:^(NSNumber *ID, NSArray *values) {
		Location *l = [DataManager createObjectOfType:DataTypeLocation ID:ID];
		l.name = values[1];
		l.lat = @([values[2] floatValue]);
		l.lon = @([values[3] floatValue]);
	}];
}

+ (void)importJobCategories {
	[self parseCSVFile:@"job_categories" withBlock:^(NSNumber *ID, NSArray *values) {
		JobCategory *jc = [DataManager createObjectOfType:DataTypeJobCategory ID:ID];
		jc.name = values[1];
	}];	
}

+ (void)importIndustryCodes {
	[self parseCSVFile:@"industry_codes" withBlock:^(NSNumber *ID, NSArray *values) {
		Industry *i = [DataManager createObjectOfType:DataTypeIndustry ID:ID];
		i.name = values[1];
	}];
}

+ (void)importFriends {
	[self parseCSVFile:@"friends" withBlock:^(NSNumber *ID, NSArray *values) {
		Friend *f = [DataManager createObjectOfType:DataTypeFriend ID:ID];
		f.name = values[1];
	}];
}

+ (void)importCompanies {
	[self parseCSVFile:@"companies" withBlock:^(NSNumber *ID, NSArray *values) {
		Company *c = [DataManager createObjectOfType:DataTypeCompany ID:ID];
		c.name = values[1];
		c.location = [DataManager objectOfType:DataTypeLocation withID:@([values[2] intValue])];
		c.numberOfEmployees = @([values[3] intValue]);
		[c addIndustries:[DataManager objectsOfType:DataTypeIndustry withIDs:[values[4] componentsSeparatedByString:@","]]];
		c.info = values[5];
		[c addFriends:[DataManager objectsOfType:DataTypeFriend withIDs:[values[6] componentsSeparatedByString:@","]]];
		
		if ([c.id isEqualToNumber:@(1)] || [c.id isEqualToNumber:@(2)]) {
			c.following = @(YES); // start out following a couple of companies
		}
	}];
}

// id,company,title,salary,experience,job_category,description,skills,link
+ (void)importJobs {
	NSArray *friends = [DataManager allObjectsOfType:DataTypeFriend];
	
	[self parseCSVFile:@"jobs" withBlock:^(NSNumber *ID, NSArray *values) {
		Job *j = [DataManager createObjectOfType:DataTypeJob ID:ID];
		j.company = [DataManager objectOfType:DataTypeCompany withID:@([values[1] integerValue])];
		j.title = values[2];
		j.salary = @([values[3] intValue]);
		j.experience = @([values[4] intValue]);
		[j addCategory:[DataManager objectsOfType:DataTypeJobCategory withIDs:[values[5] componentsSeparatedByString:@","]]];
		j.info = values[6];
		
		// friends don't have real (fake) positions so we'll just give the friend with the same ID the same position as this job
		if (ID.intValue < friends.count) {
			Friend *f = friends[ID.intValue];
			f.position = j.title;
		}
	}];
}


@end
