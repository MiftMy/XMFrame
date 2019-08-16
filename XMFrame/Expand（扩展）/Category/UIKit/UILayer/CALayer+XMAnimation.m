//
//  CALayer+XMAnimation.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "CALayer+XMAnimation.h"

@implementation CALayer (XMAnimation)
- (void)pause {
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resume {
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end
