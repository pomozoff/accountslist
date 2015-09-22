//
//  CoreDataStore.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "DataStore.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CoreDataStore <NSObject, DataStore>

@property (nullable, nonatomic, strong, readonly) NSManagedObjectContext *mainQueueManagedObjectContext;

@end

@interface CoreDataStore : NSObject <CoreDataStore>

- (instancetype)initWithModelName:(NSString *)modelName NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
