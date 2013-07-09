//
//  User.h
//  Raise
//
//  Created by Cameron Saul on 7/8/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSNumber * yearsExperience;
@property (nonatomic, retain) NSString * name;

@end
