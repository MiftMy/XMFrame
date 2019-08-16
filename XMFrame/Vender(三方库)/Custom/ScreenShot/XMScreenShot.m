//
//  XMScreenShot.m
//  XMFrame
//
//  Created by Mifit on 2019/5/31.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import "XMScreenShot.h"
#import <UIKit/UIKit.h>

@implementation XMScreenShot
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDidTakeScreenShot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    }
    return self;
}

- (instancetype)shareInstance {
    static XMScreenShot *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!obj) {
            obj = [[XMScreenShot alloc]init];
        }
    });
    return obj;
}

- (void)userDidTakeScreenShot:(NSNotification *)notify {
    if (self.didTakeScreenShotAction) {
        self.didTakeScreenShotAction();
    }
}
@end
