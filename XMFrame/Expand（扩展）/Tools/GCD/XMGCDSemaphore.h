//
//  XMGCDSemaphore.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *  GCD 信号量
 *  同时允许多少个访问
 */
@interface XMGCDSemaphore : NSObject
/// GCD信号量
@property (nonatomic, strong, readonly) dispatch_semaphore_t dispatchSemaphore;

/// 初始化。信号量为1
- (instancetype)init;

/// 初始化。信号量为value
- (instancetype)initWithValue:(long)value;

#pragma mark - 使用
/// 发送信号量。相当于释放
- (BOOL)signal;

/// 等待可用。阻塞型
- (void)wait;

/// 等待可用，等待最长时间delta
- (BOOL)wait:(int64_t)delta;
@end

NS_ASSUME_NONNULL_END
