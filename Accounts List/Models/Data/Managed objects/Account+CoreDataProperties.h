//
//  Account+CoreDataProperties.h
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"
#import "AccountManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties) <Account>

@property (nullable, nonatomic, retain) NSManagedObject *service;

@end

NS_ASSUME_NONNULL_END
