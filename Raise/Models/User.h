//
//  User.h
//  Raise
//
//  Created by Cameron Saul on 7/15/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, Job;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSNumber * yearsExperience;
@property (nonatomic, retain) NSNumber * searchAnywhere;
@property (nonatomic, retain) Job *dreamJob;
@property (nonatomic, retain) Company *dreamCompany;

@end
