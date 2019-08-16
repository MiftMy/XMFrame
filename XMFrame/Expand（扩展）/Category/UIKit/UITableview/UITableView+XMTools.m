
//
//  UITableView+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UITableView+XMTools.h"

@implementation UITableView (XMTools)

- (void)setNoneDataView:(UIView *)view {
    self.backgroundView = view;
}

- (UIView *)noneDataView {
    return self.backgroundView;
}

- (void)reloadTableAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadTableAtSection:(NSInteger)section row:(NSInteger)row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
