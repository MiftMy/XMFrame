//
//  UIScrollView+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (XMTools)
/// 滚动到最顶
- (void)scrollToTop;

/// 滚动到最下面
- (void)scrollToBottom;

/// 滚动到最左边
- (void)scrollToLeft;

/// 滚动到最右边
- (void)scrollToRight;

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (void)scrollToLeftAnimated:(BOOL)animated;

- (void)scrollToRightAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
