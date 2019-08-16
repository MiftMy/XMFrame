//
//  XMProximity.h
//  XMFrame
//
//  Created by Mifit on 2019/6/1.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *  接近传感器
 */
@interface XMProximity : NSObject
+ (void)enableProximity:(BOOL)enable;

/// ((UIDevice *)obj.object).proximityState
+ (void)proximityStateChangeBlock:(void (^)(NSNotification *notify))block;
@end

NS_ASSUME_NONNULL_END
