//
//  ExpandableTableController.h
//  ExpandableTableView
//
//  Created by Rodrigo Mato on 10/31/14.
//  Copyright (c) 2014 Rodrigo Mato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTableController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL justOneRowExpanded;

- (void)initExpansionStates;

- (void)expandRow:(NSIndexPath*)indexPath;
- (void)collapseExpandedRow:(NSIndexPath*)indexPath;
- (BOOL)isExpansionRow:(NSIndexPath*)indexPath;
- (NSIndexPath*)collapseAllRows;

- (NSIndexPath*)absoluteIndexPathFromRelativeIndexPath:(NSIndexPath*)indexPath;
- (NSInteger)numberOfFixedRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end
