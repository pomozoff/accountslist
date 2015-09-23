//
//  AccountManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

#import "DataStore.h"
#import "DataManagement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Account

@property (nullable, nonatomic, retain) NSString *login;
@property (nullable, nonatomic, retain) NSString *name;

@end

@protocol AccountDataFetcher <NSObject>

- (id <Account>)objectAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol AccountManagerDelegate <NSObject>

@property (nonnull, strong, nonatomic) id <AccountDataFetcher> accountManager;
@property (nonnull, strong, nonatomic) id <CommonDataSource, DataPresenterDelegate> commonDataSource;

@end

@interface AccountManager : NSObject <DataStoreDelegate>

@end

NS_ASSUME_NONNULL_END
