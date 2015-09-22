//
//  AccountsListAssembly.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountsListAssembly.h"
#import "CoreDataStore.h"
#import "AccountCoreDataManager.h"
#import "ServiceCoreDataManager.h"

@implementation AccountsListAssembly

#pragma mark - Public

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self dataStore]];
    }];
}
- (AccountTableViewController *)accountTableViewController {
    return [TyphoonDefinition withClass:[AccountTableViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(accountManager) with:[self accountManager]];
    }];
}

#pragma mark - Private

- (id <AccountDataFetcher>)accountManager {
    return [TyphoonDefinition withClass:[AccountCoreDataManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self dataStore]];
        definition.scope = TyphoonScopeSingleton;
    }];
}
- (id <DataStore>)dataStore {
    return [TyphoonDefinition withClass:[CoreDataStore class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithModelName:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"CommonModel"];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end
