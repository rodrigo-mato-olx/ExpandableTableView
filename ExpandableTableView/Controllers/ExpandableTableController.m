//
//  ExpandableTableController.m
//  ExpandableTableView
//
//  Created by Rodrigo Mato on 10/31/14.
//  Copyright (c) 2014 Rodrigo Mato. All rights reserved.
//

#import "ExpandableTableController.h"

@interface ExpandableTableController ()

@property (nonatomic, strong) NSMutableSet* expandedRows;

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
    
    self.tableItems = [NSMutableArray arrayWithArray:@[ @[@1, @2, @3], @[@4, @5], @[@6, @7, @8] ]];
    
}

#pragma mark - Override Class Methods

- (BOOL)shouldExpandRowAtIndexPath:(NSIndexPath*)indexPath {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - shouldExpandRowAtIndexPath:"
                                 userInfo:nil];
    return NO;
}

- (id)expandRowTypeForIndexpath:(NSIndexPath*)indexpath {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"ExpandableTableView - Calling an unimplemented abstract method - expandRowTypeForIndexpath:"
                                 userInfo:nil];
    return NO;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    BOOL rowIsExpanded = [_expandedRows containsObject:indexPath];
    
    if ( rowIsExpanded ) {
        // collapse row
    }
    else {
        
        NSUInteger newPosition = indexPath.row + 1;
        id rowType = [self expandRowTypeForIndexpath:indexPath];
        
        [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    NSDictionary *dic=[self.itemsInTable objectAtIndex:indexPath.row];
    if([dic valueForKey:@"SubItems"])
    {
        NSArray *arr=[dic valueForKey:@"SubItems"];
        BOOL isTableExpanded=NO;
        
        for(NSDictionary *subitems in arr )
        {
            NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
            isTableExpanded=(index>0 && index!=NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self CollapseRows:arr];
        }
        else
        {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arrCells=[NSMutableArray array];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.itemsInTable insertObject:dInner atIndex:count++];
            }
            [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
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


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_tableItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_tableItems[section] count];
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

@end
