//
//  FileDataFetcher.m
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "FileDataFetcher.h"

@interface FileDataFetcher ()

@property (nonnull, nonatomic, copy) NSString *filePath;

@end

@implementation FileDataFetcher

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithFilePath:@"You should set a path to a file"];
}
- (instancetype)initWithFilePath:(NSString *)filePath {
    if (self = [super init]) {
        self.filePath = filePath;
    }
    return self;
}

#pragma mark - DataFetcher

- (void)fetchDataWithCompletion:(FetchCompletionHandler)handler {
    NSData *jsonData = [NSData dataWithContentsOfFile:self.filePath];
    [self.dataParser parseData:jsonData withCompletion:^(id _Nullable collection, NSError * _Nullable error) {
        handler(collection, error);
    }];
}

@end
