//
//  Service+CoreDataProperties.h
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Service.h"
#import "ServiceManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Service (CoreDataProperties) <Service>

@property (nullable, nonatomic, retain) NSSet<Account *> *account;

@end

@interface Service (CoreDataGeneratedAccessors)

- (void)addAccountObject:(Account *)value;
- (void)removeAccountObject:(Account *)value;
- (void)addAccount:(NSSet<Account *> *)values;
- (void)removeAccount:(NSSet<Account *> *)values;

@end

NS_ASSUME_NONNULL_END
