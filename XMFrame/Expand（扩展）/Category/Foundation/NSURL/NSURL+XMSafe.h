//
//  NSURL+XMSafe.h
//  XMFrame
//
//  Created by Mifit on 2019/1/26.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSURL (XMSafe)
+ (void)loadSafe;

- (instancetype)safe_initWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL;

- (instancetype)safe_initFileURLWithPath:(NSString *)path;

- (instancetype)safe_initFileURLWithPath:(NSString *)path isDirectory:(BOOL)isDir;

- (instancetype)safe_initFileURLWithPath:(NSString *)path relativeToURL:(NSURL *)baseURL;
@end

NS_ASSUME_NONNULL_END
