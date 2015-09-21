//
//  DataStore.h
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

#import "Common.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DataStore <NSObject>

- (void)setupWithCompletionHandler:(CompletionHandler)handler;
- (void)saveDataWithCompletionHandler:(CompletionHandler)handler;

@end

NS_ASSUME_NONNULL_END
