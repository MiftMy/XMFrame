
//
//  XMProximity.m
//  XMFrame
//
//  Created by Mifit on 2019/6/1.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import "XMProximity.h"
#import <UIKit/UIKit.h>

@implementation XMProximity
+ (void)enableProximity:(BOOL)enable {
    [UIDevice currentDevice].proximityMonitoringEnabled = enable;
}

+ (void)proximityStateChangeBlock:(void (^)(NSNotification *))block {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityState) name:UIDeviceProximityStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserverForName:UIDeviceProximityStateDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:block];
}
@end
