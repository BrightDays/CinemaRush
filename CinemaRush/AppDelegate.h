//
//  AppDelegate.h
//  CinemaRush
//
//  Created by Admin on 25.05.15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveNewUser:(NSString*)login andPassword:(NSString*)password;
- (BOOL) confirmAuthorizationWithLogin:(NSString*)login andPassword:(NSString*)password;
- (BOOL) checkUniqueLogin:(NSString*)login;

@end

