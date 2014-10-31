//
//  ExpandableTableController.h
//  ExpandableTableView
//
//  Created by Rodrigo Mato on 10/31/14.
//  Copyright (c) 2014 Rodrigo Mato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTableController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* tableItems;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
