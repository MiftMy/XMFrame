//
//  NSMutableString+XMSafe.h
//  XMFrame
//
//  Created by Mifit on 2019/1/25.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSMutableString (XMSafe)
+ (void)loadSafe;

- (instancetype)safe_initWithString:(NSString *)aString;

- (void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;

- (void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;

- (void)safe_deleteCharactersInRange:(NSRange)range;

- (void)safe_appendString:(NSString *)aString;
@end

NS_ASSUME_NONNULL_END
