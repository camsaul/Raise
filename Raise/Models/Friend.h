//
//  Friend.h
//  Raise
//
//  Created by Cameron Saul on 7/10/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * position;

- (UIImage *)image;

@end
