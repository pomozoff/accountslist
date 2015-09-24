//
//  ServiceManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

#import "DataStore.h"
#import "DataManagement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Service

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *thumbnailName;

@end

@protocol ServiceDataSource <NSObject>

- (id <Service>)objectAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ServiceManagerDelegate <NSObject>

@property (nonnull, strong, nonatomic) id <ServiceDataSource> serviceManager;

@end

@interface ServiceManager : NSObject <DataStoreDelegate>

@end

NS_ASSUME_NONNULL_END
