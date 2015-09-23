//
//  AccountCoreDataManager.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountCoreDataManager.h"
#import "Account+CoreDataProperties.h"
#import "CoreDataStore.h"

@interface AccountCoreDataManager () <AccountDataFetcher>

@property (nonnull, nonatomic, strong) CoreDataStore *dataStore;

@end

@implementation AccountCoreDataManager

static NSUInteger const kBatchSize = 20;

#pragma mark - Properties

@synthesize dataStore = _dataStore;

- (void)setDataStore:(CoreDataStore *)dataStore {
    if (_dataStore != dataStore) {
        _dataStore = dataStore;
        [_dataStore setupWithCompletion:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSFetchedResultsController *frc = [self fetchedResultsControllerWithManagedObjectContext:self.dataStore.mainQueueManagedObjectContext];
                [self.dataSourceDelegate updateFetchedResultsController:frc withCompletionHandler:^(BOOL innerSucceeded, NSError *innerError) {
                    if (!innerSucceeded) {
                        NSLog(@"Setup Fetched Result Controller failed: %@", error);
                    }
                }];
            } else {
                NSLog(@"Core Data Store setup failed: %@", error);
            }
        }];
    }
}

#pragma mark - DataFetcher

- (id <Account>)objectAtIndexPath:(NSIndexPath *)indexPath {
    Account *account = [self.dataSourceDelegate objectAtIndexPath:indexPath];
    return account;
}

#pragma mark - Private

- (NSFetchedResultsController *)fetchedResultsControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Account class])];
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

@end
