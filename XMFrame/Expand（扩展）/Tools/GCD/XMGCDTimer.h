//
//  XMGCDTimer.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * GCD timer
 */
@interface XMGCDTimer : NSObject
@property (nonatomic, strong, readonly) dispatch_source_t dispatchSource;

- (instancetype)init;
- (instancetype)initWithQueue:(dispatch_queue_t)queue;

#pragma mark 使用
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
- (void)start;
- (void)destroy;
@end

NS_ASSUME_NONNULL_END
