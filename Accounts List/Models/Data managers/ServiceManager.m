//
//  ServiceManager.m
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "ServiceManager.h"
#import "CoreDataStore.h"
#import "ServiceCoreDataManager.h"

@implementation ServiceManager

#pragma mark - Properties

@synthesize dataStore = _dataStore;

#pragma mark - Initialization

- (instancetype)init {
    if ([self isMemberOfClass:[ServiceManager class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
        self = nil;
    } else if ([self isKindOfClass:[ServiceManager class]]) {
        self = [super init];
    } else {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Incompatible class type %@ as a subclass", NSStringFromClass([self class])];
        self = nil;
    }
    return self;
}

@end
