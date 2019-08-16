//
//  NSData+XMTools.h
//  XMFrame
//
//  Created by 梁小迷 on 10/8/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (XMTools)
#pragma mark - coding
/// md5
- (NSData *)md5;

/// 安全哈希算法，has1 算法，校验数据完整性，可有中文。对于长度小于2^64位的消息，SHA1会产生一个160位的消息摘要
- (NSData *)sha1;
    
/// sha256 加密。MD5发现重复，最新使用sha256
- (NSData *)hmacSha256WithKey:(NSData *)key;
    
/// base64 编码
- (NSData *)base64Data;
    
/// base64解密
- (NSData *)unbase64Data;
    
/// 异或，两次可恢复元数据
- (NSData *)oxrWithData:(NSData *)privateData;
@end

NS_ASSUME_NONNULL_END
