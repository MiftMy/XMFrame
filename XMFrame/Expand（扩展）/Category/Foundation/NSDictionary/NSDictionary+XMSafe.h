//
//  NSDictionary+XMSafe.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSDictionary (XMSafe)
+ (void)loadSafe;

- (void)safe_setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
