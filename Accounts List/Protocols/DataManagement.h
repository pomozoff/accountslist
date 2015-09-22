//
//  DataManagement.h
//  Accounts List
//
//  Created by Anton Pomozov on 22.09.15.
//  Copyright © 2015 Akademon Ltd. All rights reserved.
//

#ifndef DataManagement_h
#define DataManagement_h

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TableChangeInsert = 1,
    TableChangeDelete = 2,
    TableChangeMove   = 3,
    TableChangeUpdate = 4
} TableChangeType;

@protocol TableDataSource <NSObject>

- (NSInteger)tableNumberOfSections;
- (NSInteger)tableNumberOfRowsInSection:(NSInteger)section;
- (NSString *)tableTitleForHeaderInSection:(NSInteger)section;
- (NSInteger)tableSectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (NSArray *)tableSectionIndexTitles;

@end

@protocol CollectionDataSource <NSObject>

- (NSInteger)tableNumberOfSections;
- (NSInteger)tableNumberOfRowsInSection:(NSInteger)section;
- (NSString *)tableTitleForHeaderInSection:(NSInteger)section;
- (NSInteger)tableSectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (NSArray *)tableSectionIndexTitles;

@end

@protocol DataPresenter <NSObject>

@property (nonatomic, strong) NSBlockOperation *updateOperation;

- (void)reloadData;
- (void)willChangeContent;
- (void)didChangeSectionatIndex:(NSUInteger)sectionIndex
                  forChangeType:(TableChangeType)type;
- (void)didChangeObject:(id)anObject
            atIndexPath:(NSIndexPath *)indexPath
          forChangeType:(TableChangeType)type
           newIndexPath:(NSIndexPath *)newIndexPath;
- (void)didChangeContent;

@end

@protocol DataPresenterDelegate <NSObject>

@property (nonatomic, strong) id <DataPresenter> presenter;

@end

NS_ASSUME_NONNULL_END

#endif /* DataManagement_h */
