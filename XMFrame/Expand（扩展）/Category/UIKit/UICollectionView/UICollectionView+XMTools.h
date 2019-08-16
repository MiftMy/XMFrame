//
//  UICollectionView+XMTools.h
//  XMFrame
//
//  Created by 梁小迷 on 7/7/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (XMTools)
/// 设置没有数据时候显示的view
- (void)setNoneDataView:(UIView *)view;

/// 获取没数据时候显示的view
- (UIView *)noneDataView;
@end

NS_ASSUME_NONNULL_END
