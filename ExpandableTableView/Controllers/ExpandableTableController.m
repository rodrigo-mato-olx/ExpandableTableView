//
//  ExpandableTableController.m
//  ExpandableTableView
//
//  Created by Rodrigo Mato on 10/31/14.
//  Copyright (c) 2014 Rodrigo Mato. All rights reserved.
//

#import "ExpandableTableController.h"

@interface ExpandableTableController ()

@property (nonatomic, strong) NSMutableArray* expansionStates;

@end

@implementation ExpandableTableController

//- (id)initWithCoder:(NSCoder *)aDecoder {
//{
//    self = [super init];
//    if (self)
//    {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)initExpansionStates {
    
    self.expansionStates = [NSMutableArray new];
    NSInteger sectionsCount = [self numberOfSections];
    NSInteger rowsCount;
    
    // Create all expansion states in matrix set to NO
    for (int i=0; i < sectionsCount; i++) {
        
        rowsCount = [self numberOfFixedRowsInSection:i];
        self.expansionStates[i] = [NSMutableArray new];
        
        for (int j=0; j < rowsCount; j++)
            [self.expansionStates[i] addObject:@NO];
    }
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Expanded TableView
/////////////////////////////////////////////////////////////////////////////////////////


- (void)expandRow:(NSIndexPath*)indexPath withAbsolutePath:(NSIndexPath*)absolutePath{
    
    NSUInteger newPosition = indexPath.row + 1;
    // Add expanded row to data model
    NSMutableArray* sectionExpansionRows = self.expansionStates[indexPath.section];
    [sectionExpansionRows replaceObjectAtIndex:absolutePath.row withObject:@YES];
    
    // Insert row in tableview
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:newPosition inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

- (void)collapseExpandedRow:(NSIndexPath*)indexPath withAbsolutePath:(NSIndexPath*)absolutePath{
    
    NSIndexPath* collapsingIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    // Remove expanded row from data model
    NSMutableArray* sectionExpansionRows = self.expansionStates[indexPath.section];
    [sectionExpansionRows replaceObjectAtIndex:absolutePath.row withObject:@NO];
    
    // Remove row from tableview
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[collapsingIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

/*
 ** Indicates if the given row is currently expanded
 */
- (BOOL)rowIsExpanded:(NSIndexPath*)indexPath {
    
    if (indexPath
        && (indexPath.section < [_expansionStates count])
        && (indexPath.row < [_expansionStates[indexPath.section] count]) ) {
        
        return [_expansionStates[indexPath.section][indexPath.row] boolValue];
    }
    return NO;
}

/*
** Indicates if the given row indexpath is an expandable row or an expanded row
*/
- (BOOL)isExpansionRow:(NSIndexPath*)indexPath {
    
    NSMutableArray* sectionExpansionRows = self.expansionStates[indexPath.section];
    NSUInteger i = 0;
    NSInteger realRow = 0;
    
    while (i <= indexPath.row) {

        if ( i == indexPath.row )
            return YES;
        if ( [sectionExpansionRows[realRow] boolValue] ) {
            i++;
            if ( i == indexPath.row )
                return NO;
        }
        i++;
        realRow++;
    }
    return NO;
}

/*
** Obtains the real indexpath by substracting the expanded rows
*/
- (NSIndexPath*)absoluteIndexPathFromRelativeIndexPath:(NSIndexPath*)indexPath {
    
    if ( ![self isExpansionRow:indexPath] )
        return nil;
    
    NSInteger absoluteRow = 0;
    NSMutableArray* sectionExpandedRows = self.expansionStates[indexPath.section];
    int i = 0;
    while (i <= indexPath.row) {
        
        if ( i == indexPath.row )
            break;
        if ( [sectionExpandedRows[absoluteRow] boolValue] )
            i++;
        i++;
        absoluteRow++;
    }
    return [NSIndexPath indexPathForRow:absoluteRow inSection:indexPath.section];
}

/*
** Returns the amount of expanded rows for one section
*/
- (int)expandedRowsInSection:(NSInteger)section {
    
    return [self expandedRowsInSection:section belowRow:[self.expansionStates[section] count]];
}

/*
 ** Returns the amount of expanded rows for one section
 */
- (int)expandedRowsInSection:(NSInteger)section belowRow:(NSInteger)limitRow{
    
    NSArray* sectionStates = self.expansionStates[section];
    NSInteger limit = limitRow < [sectionStates count]? limitRow : [sectionStates count];
    int expandedRows = 0;
    for (int i=0; i < limit; i++)
        if ([sectionStates[i] boolValue])
            expandedRows++;
    return expandedRows;
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Override Class Methods
/////////////////////////////////////////////////////////////////////////////////////////


- (BOOL)shouldExpandRowAtIndexPath:(NSIndexPath*)indexPath {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - shouldExpandRowAtIndexPath:"
                                 userInfo:nil];
    return NO;
}

- (NSInteger)numberOfFixedRowsInSection:(NSInteger)section {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - numberOfFixedRowsInSection:"
                                 userInfo:nil];
    return 0;
}

- (NSInteger)numberOfSections {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - numberOfSections"
                                 userInfo:nil];
    return 0;
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableView Delegate
/////////////////////////////////////////////////////////////////////////////////////////


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( [self isExpansionRow:indexPath] ) {
        
        NSIndexPath* absolutePath = [self absoluteIndexPathFromRelativeIndexPath:indexPath];
        
        if ( absolutePath && [self shouldExpandRowAtIndexPath:absolutePath] ) {
            
            if ( [self rowIsExpanded:absolutePath] )
                [self collapseExpandedRow:indexPath withAbsolutePath:absolutePath];
            else
                [self expandRow:indexPath withAbsolutePath:absolutePath];
        }
    }
}

/*
* Requierd override - heightForRowAtIndexPath:
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - tableView:heightForRowAtIndexPath:"
                                 userInfo:nil];
    return 0;
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableView DataSource
/////////////////////////////////////////////////////////////////////////////////////////


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self numberOfFixedRowsInSection:section] + [self expandedRowsInSection:section];
}

/*
* Requierd override - cellForRowAtIndexPath:
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - tableView:heightForRowAtIndexPath:"
                                 userInfo:nil];
    return nil;
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Textfield Delegate
/////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // On ReturnKey in TextField, hide keyboard
    [textField resignFirstResponder];
    return YES;
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Textview Delegate
/////////////////////////////////////////////////////////////////////////////////////////



@end
