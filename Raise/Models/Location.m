//
//  Location.m
//  Raise
//
//  Created by Cameron Saul on 7/9/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "Location.h"

@interface LocationAnnotation : NSObject <MKAnnotation>
PROP CLLocationCoordinate2D coordinate;
PROP_COPY NSString *title;
//PROP_COPY NSString *subtitle;
@end

@implementation LocationAnnotation
@end


@implementation Location

@dynamic id;
@dynamic name;
@dynamic lat;
@dynamic lon;

- (CLLocationCoordinate2D)coordinate {
	return CLLocationCoordinate2DMake(self.lat.floatValue, self.lon.floatValue);
}

- (id<MKAnnotation>)annotation {
	LocationAnnotation *a = [[LocationAnnotation alloc] init];
	a.coordinate = self.coordinate;
	a.title = self.name;
	return a;
}

@end
