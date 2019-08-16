//
//  XMGCDSemaphore.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMGCDSemaphore.h"

@interface XMGCDSemaphore ()
@property (nonatomic, strong, readwrite) dispatch_semaphore_t dispatchSemaphore;
@end

@implementation XMGCDSemaphore
- (instancetype)init {
    if (self = [super init]) {
        self.dispatchSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (instancetype)initWithValue:(long)value {
    if (self = [super init]) {
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    return self;
}

- (BOOL)signal {
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait {
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}
@end
