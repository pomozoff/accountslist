//
//  BaseTableViewController.h
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

@import UIKit;

#import "DataManagement.h"

@interface BaseTableViewController : UITableViewController

@property (nonnull, strong, nonatomic) id <CommonDataSource, DataPresenterDelegate> commonDataSource;

@end
