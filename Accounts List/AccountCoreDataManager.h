//
//  AccountCoreDataManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import UIKit;

#import "AccountManager.h"

@interface AccountCoreDataManager : AccountManager <AccountManager, TableDataSource, AccountDataPresenter>

@end
