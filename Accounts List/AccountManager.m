//
//  AccountManager.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountManager.h"

@interface AccountManager ()

@end

@implementation AccountManager

#pragma mark - Properties

@synthesize dataStore = _dataStore;

#pragma mark - Initialization

- (instancetype)init {
    if ([self isMemberOfClass:[AccountManager class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
        self = nil;
    } else {
        self = [super init];
    }
    return self;
}

#pragma mark - DataStoreDelegate

- (void)saveChangesWithCompletion:(CompletionHandler)handler {
    [self.dataStore saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Account manager - Failed save changes: %@", error);
        }
        if (handler) {
            handler(succeeded, error);
        }
    }];
}

@end
