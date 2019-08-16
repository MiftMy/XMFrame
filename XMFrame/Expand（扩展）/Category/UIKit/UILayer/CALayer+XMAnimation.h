//
//  CALayer+XMAnimation.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XMAnimation)
/// 暂停动画
- (void)pause;

/// 恢复动画
- (void)resume;

/// 控制动画时间
//- (void)animationPersent:(CGFloat)persent;
@end

NS_ASSUME_NONNULL_END
