//
//  AccountsListAssembly.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;
@import Typhoon;

#import "AppDelegate.h"
#import "AccountTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountsListAssembly : TyphoonAssembly

- (AppDelegate *)appDelegate;
- (AccountTableViewController *)accountTableViewController;

@end

NS_ASSUME_NONNULL_END
