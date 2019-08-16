//
//  NSString+XMSafe.h
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
@interface NSString (XMSafe)
- (instancetype)safe_initWithString:(NSString *)str;

- (unichar)safe_characterAtIndex:(NSUInteger)index;

- (NSString *)safe_stringByAppendingString:(NSString *)str;

- (NSString *)safe_substringFromIndex:(NSUInteger)index;

- (NSString *)safe_substringToIndex:(NSUInteger)index;

- (NSString *)safe_substringWithRange:(NSRange)range;

- (NSString *)safe_stringByAppendingPathExtension:(NSString *)str;

- (NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;
@end

NS_ASSUME_NONNULL_END
