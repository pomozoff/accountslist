//
//  ServiceCoreDataManager.h
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "ServiceManager.h"
#import "CoreDataSource.h"

@interface ServiceCoreDataManager : ServiceManager

@property (nonnull, nonatomic, strong) id <CoreDataSourceDelegate> dataSourceDelegate;

@end
