//
//  AppDelegate.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountManager.h"

@interface AppDelegate () <DataStoreDelegate>

@end

@implementation AppDelegate

#pragma mark - Properties

@synthesize dataStore = _dataStore;

#pragma mark - Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupApperance];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.dataStore saveDataWithCompletion:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Application resign active - Failed save changes: %@", error);
        }
    }];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.dataStore saveDataWithCompletion:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Application did enter background - Failed save changes: %@", error);
        }
    }];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.dataStore saveDataWithCompletion:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Application will terminate - Failed save changes: %@", error);
        }
    }];
}

#pragma mark - Private

- (void)setupApperance {
    self.window.tintColor = [UIColor greenColor];
}

@end
