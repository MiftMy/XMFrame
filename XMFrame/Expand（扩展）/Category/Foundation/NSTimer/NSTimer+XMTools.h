//
//  NSTimer+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (XMTools)

/// 暂停NSTimer
- (void)pauseTimer;

/// 开始NSTimer
- (void)resumeTimer;

/// 延迟开始NSTimer
- (void)resumeTimerAfterDelay:(NSTimeInterval)interval;

#pragma mark - block
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;
@end

NS_ASSUME_NONNULL_END
