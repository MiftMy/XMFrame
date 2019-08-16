//
//  NSString+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XMTools)
/// 字符串长度，中文算两个。length里面中文算一个。
- (NSUInteger)textByteLength:(NSString *)text;

/// 计算多行文本高度
- (CGFloat)heightForFont:(UIFont *)font withinSize:(CGSize)size;

/// 计算多行文本高度，自定义样式
- (CGFloat)heightForFont:(UIFont *)font withinSize:(CGSize)size style:(NSMutableParagraphStyle *)style;

/// 指定字符串反向查找
+ (NSString *)reverseAllString:(NSString *)allstring findString:(NSString *)findString;

#pragma mark - coding
/// md5加密
- (NSString *_Nullable)md5;
    
/// 安全哈希算法，has1 算法，校验数据完整性，可有中文。对于长度小于2^64位的消息，SHA1会产生一个160位的消息摘要
- (NSString *_Nullable)sha1;
    
/// sha256 加密。MD5发现重复，最新使用sha256
- (NSData *_Nullable)hmacSha256WithKey:(NSString *)keyStr;

/// base64 data编码
- (NSData *_Nullable)base64Data;
    
/// base64 string
- (NSString *_Nullable)base64String;

// base64 string to 原文
- (NSString *_Nullable)unbase64String;

/// 异或，两次异或同样一个数还原数据。
- (NSString *_Nullable)xorWithString:(NSString *)privateStr;
//- (NSString *)urlEncode;

#pragma mark - check
/// 是否为空
- (BOOL)isEmpty;
    
/// 是否有效邮箱
- (BOOL)isValidEmail;

/// 是否有效电话号码
- (BOOL)isValidPhoneNum;

/// 是否纯字母
- (BOOL)isPureCharacters;

/// 判断是否是纯数字
- (BOOL)isPureNum;

/// 纯符号
- (BOOL)isPureSymbol;

#pragma mark - path
/// home目录
+ (NSString *)homeDirectory;

/// documents目录
+ (NSString *)documentsDirectory;

/// tem目录
+ (NSString *)temporaryDirectory;

/// cache目录
+ (NSString *)cachePath;
@end

NS_ASSUME_NONNULL_END
