//
//  JsonDataParser.m
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "JsonDataParser.h"

@implementation JsonDataParser

- (void)parseData:(NSData *)data withCompletion:(ParserCompletionHandler)handler {
    NSError *error = nil;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
    id collection = [NSJSONSerialization JSONObjectWithData:data
                                                    options:0
                                                      error:&error];
#pragma clang diagnostic pop
    
    if (collection) {
        handler(collection, nil);
    } else {
        NSLog(@"Unable to parse JSON: %@", error);
        handler(nil, error);
    }
}

@end
