//
//  UITableView+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (XMTools)
/// 设置没有数据时候显示的view
- (void)setNoneDataView:(UIView *)view;

/// 获取没数据时候显示的view
- (UIView *)noneDataView;

/// 刷新sectioin 0的某一行
- (void)reloadTableAtIndex:(NSInteger)index;

/// 刷新某一row
- (void)reloadTableAtSection:(NSInteger)section row:(NSInteger)row;

/// 没有数据时候设置backgroundView
@end

NS_ASSUME_NONNULL_END
