//
//  AppDelegate.h
//  Raise
//
//  Created by Cameron Saul on 7/2/13.
//  Copyright (c) 2013 LuckyBird, Inc. All rights reserved.
//

#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

PROP_STRONG UIWindow *window;

- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (RootViewController *)rootViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end