//
//  XMGCDQueue.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMGCDQueue.h"

static XMGCDQueue *g_mainQueue;
static XMGCDQueue *g_globalQueue;
static XMGCDQueue *g_highPriorityGlobalQueue;
static XMGCDQueue *g_lowPriorityGlobalQueue;
static XMGCDQueue *g_backgroundPriorityGlobalQueue;

@interface XMGCDQueue ()
@property (nonatomic, strong, readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation XMGCDQueue
+ (void)initialize {
    
    /**
     Initializes the class before it receives its first message.
     
     1. The runtime sends the initialize message to classes in a
     thread-safe manner.
     
     2. initialize is invoked only once per class. If you want to
     perform independent initialization for the class and for
     categories of the class, you should implement load methods.
     */
    if (self == [XMGCDQueue self])  {
        g_mainQueue                     = [XMGCDQueue new];
        g_globalQueue                   = [XMGCDQueue new];
        g_highPriorityGlobalQueue       = [XMGCDQueue new];
        g_lowPriorityGlobalQueue        = [XMGCDQueue new];
        g_backgroundPriorityGlobalQueue = [XMGCDQueue new];
        
        g_mainQueue.dispatchQueue                     = dispatch_get_main_queue();
        g_globalQueue.dispatchQueue                   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        g_highPriorityGlobalQueue.dispatchQueue       = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        g_lowPriorityGlobalQueue.dispatchQueue        = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        g_backgroundPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

#pragma 初始化
- (instancetype)init {
    return [self initSerial];
}

- (instancetype)initSerial {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initSerialWithLabel:(NSString *)label {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initConcurrent {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initConcurrentWithLabel:(NSString *)label {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark -
+ (instancetype)mainQueue {
    return g_mainQueue;
}

+ (instancetype)globalQueue {
    return g_globalQueue;
}

+ (instancetype)highGlobalQueue {
    return g_highPriorityGlobalQueue;
}

+ (instancetype)lowGlobalQueue {
    return g_lowPriorityGlobalQueue;
}

+ (instancetype)backgroundGlobalQueue {
    return g_backgroundPriorityGlobalQueue;
}
#pragma mark - 使用
- (void)setSpecific:(NSString *)specific value:(NSString *)vlaue {
    void *spec = [specific UTF8String];
    dispatch_queue_set_specific(self.dispatchQueue, spec, &spec, NULL);
}

- (NSString *)getSpecific:(NSString *)specific {
    void *_Nullable val = dispatch_queue_get_specific(self.dispatchQueue, [specific UTF8String]);
    if (val) {
        return [NSString stringWithUTF8String:val];
    }
    return nil;
}

+ (NSString *)currentSpecific:(NSString *)specific {
    void *_Nullable val = dispatch_get_specific([specific UTF8String]);
    if (val) {
        return [NSString stringWithUTF8String:val];
    }
    return nil;
}

- (void)sync:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_sync(self.dispatchQueue, block);
}

- (void)async:(dispatch_block_t)block {
    dispatch_async(self.dispatchQueue, block);
}

- (void)async:(dispatch_block_t)block afterDelay:(int64_t)delta {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), self.dispatchQueue, block);
}

- (void)async:(dispatch_block_t)block afterDelaySecs:(float)delta {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta * NSEC_PER_SEC), self.dispatchQueue, block);
}

- (void)asyncBarrier:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)syncBarrier:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_sync(self.dispatchQueue, block);
}

- (void)suspend {
    dispatch_suspend(self.dispatchQueue);
}

- (void)resume {
    dispatch_resume(self.dispatchQueue);
}

#pragma mark - group
- (void)async:(dispatch_block_t)block inGroup:(dispatch_group_t)group {
    NSParameterAssert(block);
    dispatch_group_async(group, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(dispatch_group_t)group {
    NSParameterAssert(block);
    dispatch_group_notify(group, self.dispatchQueue, block);
}
@end
