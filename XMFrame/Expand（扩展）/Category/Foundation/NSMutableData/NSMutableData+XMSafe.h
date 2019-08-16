//
//  NSMutableData+XMSafe.h
//  XMFrame
//
//  Created by 梁小迷 on 10/8/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSMutableData (XMSafe)
    /// dataWithData: 传nil不会蹦
    /// appendData: 传nil不会蹦
@end

NS_ASSUME_NONNULL_END
