//
//  DataFetcher.h
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

typedef void (^FetchCompletionHandler)(id __nullable collection, NSError * __nullable error);

@protocol DataFetcher <NSObject>

- (void)fetchDataWithCompletion:(FetchCompletionHandler)handler;

@end

NS_ASSUME_NONNULL_END
