//
//  BaseCollectionViewController.m
//  Accounts List
//
//  Created by Anton Pomozov on 24.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController () <CommonDataSourceDelegate, DataPresenter>

@end

@implementation BaseCollectionViewController

#pragma mark - Properties

@synthesize updateOperation = _updateOperation;
@synthesize commonDataSource = _commonDataSource;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commonDataSource.presenter = self;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes in subclass
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.commonDataSource numberOfSections];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.commonDataSource numberOfItemsInSection:section];
}

#pragma mark - DataPresenter

- (void)reloadData {
    [self.collectionView reloadData];
}
- (void)willChangeContent {
    [self.collectionView beginUpdates];
    self.updateOperation = [[NSBlockOperation alloc] init];
}
- (void)didChangeSectionatIndex:(NSUInteger)sectionIndex
                  forChangeType:(TableChangeType)type
{
    __weak UICollectionView *weakCollectionView = self.collectionView;
    switch(type) {
        case TableChangeInsert: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
        case TableChangeDelete: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
        case TableChangeUpdate: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
        case TableChangeMove: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
                [weakCollectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
        default:
            break;
    }
}
- (void)didChangeObject:(id)anObject
            atIndexPath:(NSIndexPath *)indexPath
          forChangeType:(TableChangeType)type
           newIndexPath:(NSIndexPath *)newIndexPath
{
    __weak UICollectionView *weakCollectionView = self.collectionView;
    switch(type) {
        case TableChangeInsert: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
            }];
            break;
        }
        case TableChangeDelete: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView deleteItemsAtIndexPaths:@[newIndexPath]];
            }];
            break;
        }
        case TableChangeUpdate: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView reloadItemsAtIndexPaths:@[newIndexPath]];
            }];
            break;
        }
        case TableChangeMove: {
            [self.updateOperation addExecutionBlock:^{
                [weakCollectionView deleteItemsAtIndexPaths:@[newIndexPath]];
                [weakCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
            }];
            break;
        }
        default:
            break;
    }
}
- (void)didChangeContent {
    [self.updateOperation start];
}

@end
