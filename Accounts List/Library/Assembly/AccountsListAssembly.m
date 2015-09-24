//
//  AccountsListAssembly.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountsListAssembly.h"
#import "CoreDataStore.h"
#import "CoreDataSource.h"
#import "AccountCoreDataManager.h"
#import "ServiceCoreDataManager.h"

@interface AccountsListAssembly ()

@property (nonatomic, strong) CoreDataSource *coreDataSource;

@end

@implementation AccountsListAssembly

- (CoreDataSource *)coreDataSource {
    if (!_coreDataSource) {
        _coreDataSource = [TyphoonDefinition withClass:[CoreDataSource class]];
    }
    return _coreDataSource;
}

#pragma mark - Public

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self dataStoreMaker]];
    }];
}
- (AccountTableViewController *)accountTableViewController {
    return [TyphoonDefinition withClass:[AccountTableViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(accountManager) with:[self accountManagerMaker]];
        [definition injectProperty:@selector(commonDataSource) with:self.coreDataSource];
    }];
}

#pragma mark - Private

- (id <AccountDataSource>)accountManagerMaker {
    return [TyphoonDefinition withClass:[AccountCoreDataManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self dataStoreMaker]];
        [definition injectProperty:@selector(dataSourceDelegate) with:self.coreDataSource];
    }];
}
- (id <CoreDataSourceDelegate>)dataSourceDelegateMaker {
    return self.coreDataSource;
}
- (id <DataStore>)dataStoreMaker {
    return [TyphoonDefinition withClass:[CoreDataStore class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithModelName:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"CommonModel"];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end
