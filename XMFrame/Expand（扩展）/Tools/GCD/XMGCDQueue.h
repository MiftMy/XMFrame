//
//  XMGCDQueue.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGCDQueue : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t dispatchQueue;
/// 主线程queue
+ (instancetype)mainQueue;
/// 全局quue。级别默认default
+ (instancetype)globalQueue;

+ (instancetype)highGlobalQueue;
+ (instancetype)lowGlobalQueue;
+ (instancetype)backgroundGlobalQueue;

#pragma 初始化
/// 默认同步线程
- (instancetype)init;
- (instancetype)initSerial;// 无label
- (instancetype)initSerialWithLabel:(NSString *)label;
- (instancetype)initConcurrent;// 无lebel
- (instancetype)initConcurrentWithLabel:(NSString *)label;

#pragma mark - 使用
/// 设置queue标识，用于判断当前队列是否为自己
- (void)setSpecific:(NSString *)specific value:(NSString *)vlaue;
/// 获取queue标识
- (NSString *)getSpecific:(NSString *)specific;
/// 当前XMGCDQueue所在队列的标识，可用于判断是否等于自己的dspecific
+ (NSString *)currentSpecific:(NSString *)specific;

/// 同步执行
- (void)sync:(dispatch_block_t)block;
/// 异步执行
- (void)async:(dispatch_block_t)block;
- (void)async:(dispatch_block_t)block afterDelay:(int64_t)delta;
- (void)async:(dispatch_block_t)block afterDelaySecs:(float)delta;

/// 栏栅：执行完所有的async block，才执行barrier里面的block
- (void)asyncBarrier:(dispatch_block_t)block;
- (void)syncBarrier:(dispatch_block_t)block;
- (void)suspend;
- (void)resume;

#pragma mark - group关联
- (void)async:(dispatch_block_t)block inGroup:(dispatch_group_t)group;
- (void)notify:(dispatch_block_t)block inGroup:(dispatch_group_t)group;
@end

NS_ASSUME_NONNULL_END
