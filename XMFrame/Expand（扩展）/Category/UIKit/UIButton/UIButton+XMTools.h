//
//  UIButton+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^touchupBlock)(NSInteger tag);

@interface UIButton (XMTools)
/// 点击区域
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/// block回调touchupInside事件
- (void)addActionHandler:(touchupBlock)touchHandler;
@end

NS_ASSUME_NONNULL_END
