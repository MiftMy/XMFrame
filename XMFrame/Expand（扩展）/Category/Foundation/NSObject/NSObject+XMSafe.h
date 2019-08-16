//
//  NSObject+XMSafe.h
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSObject (XMSafe)
// 崩溃处理
// 1、+ (BOOL)resolveInstanceMethod:(SEL)name                    有些系统方法在此处理了，实现了添加函数代码则返回YES，未实现返回NO。
// 2、- (id)forwardingTargetForSelector:(SEL)aSelector           只有方法名，但开销比较小
// 3、- (void)forwardInvocation:(NSInvocation *)anInvocation     可以拿到参数，但开销比较大
// 4、- (void)doesNotRecognizeSelector:(SEL)aSelector            调用了无法识别的方法，必崩溃
@end

NS_ASSUME_NONNULL_END
