//
//  TestCaseViewController.m
//  ExpandableTableView
//
//  Created by Rodrigo Mato on 11/4/14.
//  Copyright (c) 2014 Rodrigo Mato. All rights reserved.
//

#import "TestCaseViewController.h"

@interface TestCaseViewController ()

@property (nonatomic, strong) NSArray* tableItems;

@end

@implementation TestCaseViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableItems = @[@[@"0-0", @"0-1", @"0-2"], @[@"1-0", @"1-1"], @[@"2-0", @"2-1", @"2-2", @"2-3"]];
    [self initExpansionStates];
}

#pragma mark - Override Expandable Table

- (NSInteger)numberOfFixedRowsInSection:(NSInteger)section {
    return [self.tableItems[section] count];
}

- (NSInteger)numberOfSections {
    return [self.tableItems count];
}

- (BOOL)shouldExpandRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ( [self isExpansionRow:indexPath] ) {
        NSIndexPath* absolutePath = [self absoluteIndexPathFromRelativeIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor redColor]];
        cell.textLabel.text = self.tableItems[absolutePath.section][absolutePath.row];
    }
    else{
        [cell setBackgroundColor:[UIColor grayColor]];
        cell.textLabel.text = @"Expanded";
    }
    
    return cell;
}

@end
