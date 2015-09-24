//
//  ServiceCoreDataManager.m
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "ServiceCoreDataManager.h"
#import "Service+CoreDataProperties.h"
#import "CoreDataStore.h"

@interface ServiceCoreDataManager () <ServiceDataSource>

@property (nonatomic, strong) CoreDataStore *dataStore;

@end

@implementation ServiceCoreDataManager

static NSUInteger const kBatchSize = 20;

#pragma mark - Properties

@synthesize dataStore = _dataStore;

- (void)setDataStore:(CoreDataStore *)dataStore {
    if (_dataStore != dataStore) {
        _dataStore = dataStore;
        [_dataStore setupWithCompletion:^(BOOL succeeded, NSError *error) {
            [self didCompleteCoreDataSetup:succeeded withError:error];
        }];
    }
}

#pragma mark - ServiceDataSource

- (id <Service>)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceDelegate objectAtIndexPath:indexPath];
}

#pragma mark - Private

- (NSFetchedResultsController *)fetchedResultsControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Service class])];
    request.predicate = nil;
    request.fetchBatchSize = kBatchSize;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                          managedObjectContext:managedObjectContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    return frc;
}

#pragma mark - Callback handlers

- (void)didCompleteCoreDataSetup:(BOOL)succeeded withError:(NSError *)error {
    if (succeeded) {
        NSFetchedResultsController *frc = [self fetchedResultsControllerWithManagedObjectContext:self.dataStore.mainQueueManagedObjectContext];
        [self.dataSourceDelegate updateFetchedResultsController:frc withCompletion:^(BOOL innerSucceeded, NSError *innerError) {
            [self didUpdateFetchedResultsController:innerSucceeded withError:innerError];
        }];
    } else {
        NSLog(@"Core Data Store setup failed: %@", error);
    }
}
- (void)didUpdateFetchedResultsController:(BOOL)succeeded withError:(NSError *)error {
    if (succeeded) {
        [self.dataFetcher fetchDataWithCompletion:^(id _Nullable collection, NSError * _Nullable innerError) {
            [self didFetchData:collection withError:innerError];
        }];
    } else {
        NSLog(@"Setup Fetched Result Controller failed: %@", error);
    }
}
- (void)didFetchData:(id _Nullable)collection withError:(NSError *)error {
    if (collection && !error) {
        
    } else if (error) {
        NSLog(@"Fetching services failed: %@", error);
    } else {
        NSLog(@"Fetching services failed, with unknown error");
    }
}

@end
