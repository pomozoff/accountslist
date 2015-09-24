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
#import "FileDataFetcher.h"
#import "JsonDataParser.h"

@interface AccountsListAssembly ()

@property (nonatomic, strong) id <DataStore> coreDataStore;
@property (nonatomic, strong) CoreDataSource *coreDataSource;

@end

@implementation AccountsListAssembly

static NSString * const kCoreDataModelName = @"CommonModel";
static NSString * const kServicesFileName = @"ServicesList";
static NSString * const kJsonExtension = @"json";

#pragma mark - Properties

- (id <DataStore>)coreDataStore {
    if (!_coreDataStore) {
        _coreDataStore = [TyphoonDefinition withClass:[CoreDataStore class] configuration:^(TyphoonDefinition *definition) {
            [definition useInitializer:@selector(initWithModelName:) parameters:^(TyphoonMethod *initializer) {
                [initializer injectParameterWith:kCoreDataModelName];
            }];
            definition.scope = TyphoonScopeSingleton;
        }];
    }
    return _coreDataStore;
}
- (CoreDataSource *)coreDataSource {
    if (!_coreDataSource) {
        _coreDataSource = [TyphoonDefinition withClass:[CoreDataSource class]];
    }
    return _coreDataSource;
}

#pragma mark - Public

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self coreDataStoreGenerator]];
    }];
}
- (AccountTableViewController *)accountTableViewController {
    return [TyphoonDefinition withClass:[AccountTableViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(accountManager) with:[self accountCoreDataManager]];
        [definition injectProperty:@selector(commonDataSource) with:[self coreDataSourceGenerator]];
    }];
}
- (ServicesCollectionViewController *)servicesCollectionViewController {
    return [TyphoonDefinition withClass:[ServicesCollectionViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(serviceManager) with:[self serviceCoreDataManager]];
        [definition injectProperty:@selector(commonDataSource) with:[self coreDataSourceGenerator]];
    }];
}

#pragma mark - Private

- (id <DataStore>)coreDataStoreGenerator {
    return self.coreDataStore;
}
- (CoreDataSource *)coreDataSourceGenerator {
    return self.coreDataSource;
}
- (id <DataStoreDelegate>)accountCoreDataManager {
    return [TyphoonDefinition withClass:[AccountCoreDataManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self coreDataStoreGenerator]];
        [definition injectProperty:@selector(dataSourceDelegate) with:[self coreDataSourceGenerator]];
    }];
}
- (id <ServiceDataSource>)serviceCoreDataManager {
    return [TyphoonDefinition withClass:[ServiceCoreDataManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataStore) with:[self coreDataStoreGenerator]];
        [definition injectProperty:@selector(dataSourceDelegate) with:[self coreDataSourceGenerator]];
        [definition injectProperty:@selector(dataFetcher) with:[self fileDataFetcher]];
    }];
}
- (id <DataFetcher>)fileDataFetcher {
    return [TyphoonDefinition withClass:[FileDataFetcher class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataParser) with:[self jsonDataParser]];
    }];
}
- (id <DataParser>)jsonDataParser {
    return [TyphoonDefinition withClass:[JsonDataParser class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFilePath:) parameters:^(TyphoonMethod *initializer) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:kServicesFileName ofType:kJsonExtension];
            [initializer injectParameterWith:filePath];
        }];
    }];
}

@end
