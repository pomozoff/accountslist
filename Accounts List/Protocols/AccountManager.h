//
//  AccountManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

#import "DataStore.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TableChangeInsert = 1,
    TableChangeDelete = 2,
    TableChangeMove   = 3,
    TableChangeUpdate = 4
} TableChangeType;

@protocol Account

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *login;

@end

typedef void (^FetchCompletionHandler)(NSArray <id <Account>> * __nullable array, NSError * __nullable error);

@protocol DataStoreDelegate <NSObject>

@property (nonatomic, strong, readonly) id <DataStore> dataStore;
- (void)saveChangesWithCompletion:(CompletionHandler)handler;

@end

@protocol AccountManager <NSObject>

- (void)fetchAccountsWithCompletion:(FetchCompletionHandler)handler;
- (id <Account>)objectAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol TableDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (NSArray *)sectionIndexTitles;

@end

@protocol AccountDataPresentable <NSObject>

- (void)reloadData;
- (void)willChangeContent;
- (void)didChangeSectionatIndex:(NSUInteger)sectionIndex
                  forChangeType:(TableChangeType)type;
- (void)didChangeObject:(id)anObject
            atIndexPath:(NSIndexPath *)indexPath
          forChangeType:(TableChangeType)type
           newIndexPath:(NSIndexPath *)newIndexPath;
- (void)didChangeContent;

@end

@protocol AccountDataPresenter <NSObject>

@property (nonatomic, strong) id <AccountDataPresentable> presenter;

@end

@protocol AccountManagerDelegate <NSObject>

@property (nonnull, strong, nonatomic) id <DataStoreDelegate, AccountManager, TableDataSource, AccountDataPresenter> accountManager;

@end

@interface AccountManager : NSObject <DataStoreDelegate>

@end

NS_ASSUME_NONNULL_END