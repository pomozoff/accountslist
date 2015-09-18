//
//  AccountsListAssembly.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountsListAssembly.h"
#import "StartUpConfiguratorBase.h"

@implementation AccountsListAssembly

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(startUpConfigurator) with:[self startUpConfigurator]];
    }];
}

- (id <StartUpConfigurator>)startUpConfigurator {
    return [TyphoonDefinition withClass:[StartUpConfiguratorBase class]];
}

@end
