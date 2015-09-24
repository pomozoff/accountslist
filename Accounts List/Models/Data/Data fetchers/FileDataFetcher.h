//
//  FileDataFetcher.h
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import Foundation;

#import "DataFetcher.h"
#import "DataParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileDataFetcher : NSObject <DataFetcher>

@property (nonnull, nonatomic, strong) id <DataParser> dataParser;

- (instancetype)initWithFilePath:(NSString *)filePath NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
