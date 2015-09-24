//
//  AccountTableViewController.m
//  Accounts List
//
//  Created by Anton Pomozov on 18.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "AccountTableViewController.h"
#import "AccountManager.h"
#import "AccountTableViewCell.h"

@interface AccountTableViewController () <AccountManagerDelegate>

@end

@implementation AccountTableViewController

static NSString * const kCellReuseIdentifier = @"Account Cell";

#pragma mark - Properties

@synthesize accountManager = _accountManager;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Private

- (void)updateCell:(AccountTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    id <Account> account = [self.accountManager objectAtIndexPath:indexPath];
    cell.name = account.name;
}

@end
