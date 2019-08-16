//
//  XMOperationQueue.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMOperationQueue : NSObject

@property (nonatomic, readonly, strong) NSOperationQueue *operationQueue;

+ (instancetype)mainQueue;

- (void)addBlock:(void (^)(void))block;

- (void)addSelector:(SEL)selector target:(id)target;

- (void)addSelector:(SEL)selector target:(id)target obj:(nullable id)obj;

/// 暂停执行
- (void)suspend;

/// 回复执行
- (void)resume;

/// 当前opertaion个数
- (NSInteger)currentCount;

/// operation 最大数量
- (void)setMaxCount:(NSInteger)count;

/// 取消所有operation操作
- (void)cancelAllOperations;

/// 等待所有operation执行完毕。阻塞型。
- (void)waitUntilAllOperationsFinished;
@end

NS_ASSUME_NONNULL_END
