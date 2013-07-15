//
//  SearchCity.m
//  Raise
//
//  Created by Cameron Saul on 7/11/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "SearchCity.h"
#import "DataManager.h"

@implementation SearchCity

@dynamic name;
@dynamic selected;
@dynamic id;

+ (NSArray *)selectedLocations {
	return [DataManager objectsOfType:DataTypeSearchCity withPredicate:[NSPredicate predicateWithFormat:@"selected == TRUE"]];
}

@end
