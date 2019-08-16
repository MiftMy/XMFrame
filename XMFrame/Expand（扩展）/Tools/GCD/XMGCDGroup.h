//
//  XMGCDGroup.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * 当锁用
 */
@interface XMGCDGroup : NSObject
@property (nonatomic, strong, readonly) dispatch_group_t dispatchGroup;

- (instancetype)initWithQueue:(dispatch_queue_t)queue;

/// 进入。进入必须调用leave，不然其他等待的线程就永远进不去。
- (void)enter;

/// 离开。与enter保持一对，达到锁功能。
- (void)leave;

/// 等待。一直等待，等待是否能进入。
- (void)wait;

/// 等待delta时间
- (BOOL)wait:(int64_t)delta;

/// 调用initWithQueue:方可使用该方法，不然使用下面一组
- (void)asyncBlock:(dispatch_block_t)block;
/// 栏栅。达到阻拦作用，所有asyncBlock执行完毕才执行notify
- (void)notifyBlock:(dispatch_block_t)block;

/// 同上一组功能
- (void)async:(dispatch_queue_t)queue block:(dispatch_block_t)block;
- (void)notify:(dispatch_queue_t)queue block:(dispatch_block_t)block;
@end

NS_ASSUME_NONNULL_END
