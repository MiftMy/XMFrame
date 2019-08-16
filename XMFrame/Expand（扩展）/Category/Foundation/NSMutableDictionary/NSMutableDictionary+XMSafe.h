//
//  NSMutableDictionary+XMSafe.h
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
@interface NSMutableDictionary (XMSafe)
// setValue:forKey:     key 为空崩溃
// setObject:forKey:    key 为空崩溃
// 下标                  key为空不崩溃
// valueForKey:         key 为空不崩
// objectForKey:        key 为空不崩
// valueForKeyPath:     key 为空不崩
+ (void)loadSafe;

- (void)safe_setValue:(id)value forKey:(NSString *)key;

- (void)safe_setObject:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
