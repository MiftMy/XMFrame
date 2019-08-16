//
//  XMCrypt.h
//  XMFrame
//
//  Created by 梁小迷 on 10/8/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMCrypt : NSObject
#pragma mark - md5
+ (void)md5Bytes:(const char *)bytes len:(NSInteger)len output:(unsigned char *)outBuf;
    
+ (NSData *)md5Data:(NSData *)data;
    
+ (NSString *)md5String:(NSString *)str;

#pragma mark - sha
#pragma mark sha1
+ (void)sha1Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output;
    
+ (NSData *)sha1Data:(NSData *)data;
    
+ (NSString *)sha1String:(NSString *)str;

#pragma mark sha256
+ (void)sha256Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output;
    
+ (NSData *)sha256Data:(NSData *)data;
    
+ (NSString *)sha256String:(NSString *)str;
    
#pragma mark sha384
+ (void)sha384Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output;
    
+ (NSData *)sha384Data:(NSData *)data;
    
+ (NSString *)sha384String:(NSString *)str;
    
#pragma mark sha512
+ (void)sha512Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output;
    
+ (NSData *)sha512Data:(NSData *)data;
    
+ (NSString *)sha512String:(NSString *)str;
    
#pragma mark - base64
+ (NSData *_Nullable)base64Bytes:(const char *)bytes len:(int)len;
    
+ (NSData *_Nullable)base64Data:(NSData *)data;
    
+ (NSData *_Nullable)base64String:(NSString *)str;
    
#pragma mark - xor
+ (NSString *)xorWithString:(NSString *)str withPrivate:(NSString *)privateStr;
@end

NS_ASSUME_NONNULL_END
