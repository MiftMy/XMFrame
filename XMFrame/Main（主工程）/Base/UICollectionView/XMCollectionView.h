//
//  XMCollectionView.h
//  XMFrame
//
//  Created by 梁小迷 on 7/7/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMNoneDataType.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMCollectionView : UICollectionView
/// 没数据类型。刷新数据时候会相应显示。
@property (nonatomic, assign) XMNoneDataType noneType;

/// 更新数据
- (void)xm_reloadData;

/// 没数据时候显示的view。设置了就不会显示noneType对应的view，优先自己设置的。
- (void)setNoneView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
