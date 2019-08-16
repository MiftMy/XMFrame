//
//  XMOperationQueue.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMOperationQueue.h"

static XMOperationQueue *g_mainQueue;

@interface XMOperationQueue ()
@property (nonatomic, readwrite, strong) NSOperationQueue *operationQueue;
@end

@implementation XMOperationQueue

+ (void)initialize {
    if (self == [XMOperationQueue self])  {
        g_mainQueue                     = [XMOperationQueue new];
        g_mainQueue.operationQueue      = [NSOperationQueue mainQueue];
    }
}

+ (instancetype)mainQueue {
    return g_mainQueue;
}

- (instancetype)init {
    if (self = [super init]) {
        self.operationQueue = [NSOperationQueue new];
    }
    return self;
}

- (void)addBlock:(void (^)(void))block {
    [self.operationQueue addOperationWithBlock:block];
}

- (void)addSelector:(SEL)selector target:(id)target {
    [self addSelector:selector target:target obj:nil];
}

- (void)addSelector:(SEL)selector target:(id)target obj:(nullable id)obj {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:target selector:selector object:obj];
    [self.operationQueue addOperation:invocationOperation];
}

- (void)suspend {
    self.operationQueue.suspended = YES;
}

- (void)resume {
    self.operationQueue.suspended = NO;
}

- (NSInteger)currentCount {
    return self.operationQueue.operationCount;
}

- (void)setMaxCount:(NSInteger)count {
    self.operationQueue.maxConcurrentOperationCount = count;
}

- (void)cancelAllOperations {
    [self.operationQueue cancelAllOperations];
}

/// 等待所有operation执行完毕。阻塞型。
- (void)waitUntilAllOperationsFinished {
    [self.operationQueue waitUntilAllOperationsAreFinished];
}
@end
