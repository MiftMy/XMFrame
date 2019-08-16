//
//  XMGCDGroup.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMGCDGroup.h"

@interface XMGCDGroup ()
@property (nonatomic, strong, readwrite) dispatch_group_t dispatchGroup;
@property (nonatomic, strong, readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation XMGCDGroup

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    if (self = [super init]) {
        self.dispatchGroup = dispatch_group_create();
        NSString *queueName = [NSString stringWithFormat:@"mifit.queue.%.2f", [[NSDate new]timeIntervalSince1970]];
        self.dispatchQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

- (void)asyncBlock:(dispatch_block_t)block {
    dispatch_group_async(self.dispatchGroup, self.dispatchQueue, block);
}

- (void)notifyBlock:(dispatch_block_t)block {
    dispatch_group_notify(self.dispatchGroup, self.dispatchQueue, block);
}

- (void)async:(dispatch_queue_t)queue block:(dispatch_block_t)block {
    dispatch_group_async(self.dispatchGroup, queue, block);
}

- (void)notify:(dispatch_queue_t)queue block:(dispatch_block_t)block {
    dispatch_group_notify(self.dispatchGroup, queue, block);
}
@end
