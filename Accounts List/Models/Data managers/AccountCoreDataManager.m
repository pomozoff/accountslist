//
//  AccountCoreDataManager.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import CoreData;

#import "AccountCoreDataManager.h"
#import "ErrorHelper.h"
#import "CoreDataStore.h"
#import "Account+CoreDataProperties.h"

@interface AccountCoreDataManager () <NSFetchedResultsControllerDelegate, AccountDataFetcher, TableDataSource, DataPresenterDelegate>

@property (nonatomic, strong) CoreDataStore *dataStore;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AccountCoreDataManager

typedef NS_ENUM(NSUInteger, AccountCoreDataManagerError) {
    ErrorFetchedResultsControllerIsEmpty,
};

static NSString * const kAccountCoreDataManagerErrorDomain = @"AccountCoreDataManagerErrorDomain";
static NSUInteger const kBatchSize = 20;

#pragma mark - Properties

@synthesize dataStore = _dataStore;
@synthesize presenter = _presenter;

- (void)setDataStore:(CoreDataStore *)dataStore {
    if (_dataStore != dataStore) {
        _dataStore = dataStore;
        [_dataStore setupWithCompletion:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSFetchedResultsController *frc = [self fetchedResultsControllerWithManagedObjectContext:self.dataStore.mainQueueManagedObjectContext];
                [self updateFetchedResultsController:frc withCompletionHandler:^(BOOL innerSucceeded, NSError *innerError) {
                    [self.presenter reloadData];
                }];
            } else {
                NSLog(@"Core Data Store setup failed: %@", error);
            }
        }];
    }
}

#pragma mark - TableDataSource

- (NSInteger)tableNumberOfSections {
    return (NSInteger)self.fetchedResultsController.sections.count;
}
- (NSInteger)tableNumberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.fetchedResultsController.sections.count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:(NSUInteger)section];
        rows = (NSInteger)sectionInfo.numberOfObjects;
    }
    return rows;
}
- (NSString *)tableTitleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:(NSUInteger)section];
    return sectionInfo.name;
}
- (NSInteger)tableSectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}
- (NSArray *)tableSectionIndexTitles {
    return [self.fetchedResultsController sectionIndexTitles];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.presenter willChangeContent];
}
- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    [self.presenter didChangeSectionatIndex:sectionIndex
                              forChangeType:(TableChangeType)type];
}
- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.presenter didChangeObject:anObject
                        atIndexPath:indexPath
                      forChangeType:(TableChangeType)type
                       newIndexPath:newIndexPath];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.presenter didChangeContent];
}

#pragma mark - DataFetcher

- (id <Account>)objectAtIndexPath:(NSIndexPath *)indexPath {
    Account *account = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return account;
}

#pragma mark - Private

- (void)updateFetchedResultsController:(NSFetchedResultsController *)newfrc withCompletionHandler:(CompletionHandler)handler {
    NSFetchedResultsController *oldfrc = _fetchedResultsController;
    if (newfrc != oldfrc) {
        _fetchedResultsController = newfrc;
        newfrc.delegate = self;
        if (newfrc) {
            [self performFetchWithCompletionHandler:handler];
        } else {
            handler(YES, nil);
        }
    }
}
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
- (void)performFetchWithCompletionHandler:(CompletionHandler)handler {
    NSError *customError = nil;
    if (self.fetchedResultsController) {
        NSError *error = nil;
        BOOL success = [self.fetchedResultsController performFetch:&error];
        
        if (success) {
            handler(YES, nil);
        } else {
            NSString *className = NSStringFromClass([self class]);
            NSString *selectorName = NSStringFromSelector(_cmd);
            
            NSString *customErrorText = [NSString stringWithFormat:@"[%@ %@] performFetch: failed.", className, selectorName];
            NSLog(@"%@", customErrorText);
            if (error) {
                customError = [NSError errorWithDomain:kAccountCoreDataManagerErrorDomain code:error.code userInfo:error.userInfo];
                NSLog(@"[%@ %@] %@ (%@)", className, selectorName, error.localizedDescription, error.localizedFailureReason);
            } else {
                customError = [ErrorHelper createErrorWithCode:ErrorFetchedResultsControllerIsEmpty
                                                   description:NSLocalizedString(customErrorText, nil)
                                                    suggestion:NSLocalizedString(@"Nobody knows what to do. Try again later", nil)
                                                       options:@[@"Try Again", @"Cancel"]
                                                   errorDomain:kAccountCoreDataManagerErrorDomain];
            }
            handler(NO, customError);
        }
    } else {
        NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        customError = [ErrorHelper createErrorWithCode:ErrorFetchedResultsControllerIsEmpty
                                           description:NSLocalizedString(@"Fetched result controller is empty.", nil)
                                            suggestion:NSLocalizedString(@"Try to initialize it before use.", nil)
                                               options:@[@"Try Again", @"Cancel"]
                                           errorDomain:kAccountCoreDataManagerErrorDomain];
        handler(NO, customError);
    }
}

@end
