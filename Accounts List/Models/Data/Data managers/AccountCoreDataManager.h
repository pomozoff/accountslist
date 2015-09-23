//
//  AccountCoreDataManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountManager.h"
#import "CoreDataSource.h"

@interface AccountCoreDataManager : AccountManager

@property (nonnull, nonatomic, strong) id <CoreDataSourceDelegate> dataSourceDelegate;

@end
