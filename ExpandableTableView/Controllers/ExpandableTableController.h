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

- (void)initExpansionStates;
- (BOOL)isExpansionRow:(NSIndexPath*)indexPath;
- (NSIndexPath*)absoluteIndexPathFromRelativeIndexPath:(NSIndexPath*)indexPath;
- (NSInteger)numberOfFixedRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end
