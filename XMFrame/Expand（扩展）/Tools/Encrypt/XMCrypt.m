//
//  XMCrypt.m
//  XMFrame
//
//  Created by 梁小迷 on 10/8/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMCrypt.h"

#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMac.h>


@implementation XMCrypt
    #pragma mark - md5
+ (void)md5Bytes:(const char *)bytes len:(NSInteger)len output:(unsigned char *)outBuf {
    if (len <= 0 || bytes == NULL || NULL == outBuf) {
        return;
    }
    CC_MD5(bytes, (uint) len, outBuf);
    [self printBuffer:outBuf];
}
    
+ (NSData *)md5Data:(NSData *)data {
    if (data.length <= 0) {
        return nil;
    }
    char orgBuf[data.length];
    [data getBytes:orgBuf length:data.length];
    unsigned char md5Buf[CC_MD5_DIGEST_LENGTH];
    [self md5Bytes:orgBuf len:data.length output:md5Buf];
    [self printBuffer:md5Buf];
    return [[NSData alloc]initWithBytes:md5Buf length:CC_MD5_DIGEST_LENGTH];
}
    
+ (NSString *)md5String:(NSString *)str {
    if (str.length <= 0) {
        return nil;
    }
    // Create pointer to the string as UTF8
    const char *ptr = [str UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (uint) strlen(ptr), md5Buffer);
    [self printBuffer:md5Buffer];
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", md5Buffer[i]];
    
    return output;
}

#pragma mark - sha
#pragma mark sha1
+ (void)sha1Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(bytes, len, digest);
    [self printBuffer:digest];
}

+ (NSData *)sha1Data:(NSData *)data {
    return [self shaObject:data type:0];
}

+ (NSString *)sha1String:(NSString *)str {
    return [self shaObject:str type:0];
}
#pragma mark sha256
+ (void)sha256Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA1(bytes, len, digest);
    [self printBuffer:digest];
}
    
+ (NSData *)sha256Data:(NSData *)data {
    return [self shaObject:data type:1];
}
    
+ (NSString *)sha256String:(NSString *)str {
    return [self shaObject:str type:1];
}

#pragma mark sha384
+ (void)sha384Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output {
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA1(bytes, len, digest);
    [self printBuffer:digest];
}
    
+ (NSData *)sha384Data:(NSData *)data {
    return [self shaObject:data type:2];
}
    
+ (NSString *)sha384String:(NSString *)str {
    return [self shaObject:str type:2];
}
    
#pragma mark sha384
+ (void)sha512Bytes:(const char *)bytes len:(int)len output:(unsigned char *)output {
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA1(bytes, len, digest);
    [self printBuffer:digest];
}
    
+ (NSData *)sha512Data:(NSData *)data {
    return [self shaObject:data type:3];
}
    
+ (NSString *)sha512String:(NSString *)str {
    return [self shaObject:str type:3];
}
#pragma mark inner
/*
 *   obj : NSStirng、NSMutableString、NSData、NSMutableData
 *   type: 0:sha1   1:sha256   2:256   3:512
 */
+ (id _Nullable)shaObject:(id)obj type:(NSInteger)type {
    NSInteger orgLen = 0;
    NSData *orgData = nil;
    NSInteger objType = -1; // 0：字符串  1：NSData
    if ([obj isMemberOfClass:[NSString class]] || [obj isMemberOfClass:[NSMutableString class]]) {
        NSString *str = (NSString *)obj;
        orgLen = str.length;
        orgData = [str dataUsingEncoding:NSUTF8StringEncoding];
        objType = 0;
    }
    if ([obj isMemberOfClass:[NSData class]] || [obj isMemberOfClass:[NSMutableData class]]) {
        orgData = (NSData *)obj;
        orgLen = orgData.length;
        objType = 1;
    }
    if (orgLen <= 0) {
        return nil;
    }
    const char *bytes = orgData.bytes;
    uint8_t digest[CC_SHA512_DIGEST_LENGTH]; // 使用最大
    NSInteger desLen = 0;
    if (type == 0) {
        desLen = CC_SHA1_DIGEST_LENGTH;
        CC_SHA1(bytes, CC_SHA1_DIGEST_LENGTH, digest);
    }
    if (type == 1) {
        desLen = CC_SHA256_DIGEST_LENGTH;
        CC_SHA256(bytes, CC_SHA256_DIGEST_LENGTH, digest);
    }
    if (type == 2) {
        desLen = CC_SHA384_DIGEST_LENGTH;
        CC_SHA384(bytes, CC_SHA384_DIGEST_LENGTH, digest);
    }
    if (type == 3) {
        desLen = CC_SHA512_DIGEST_LENGTH;
        CC_SHA512(bytes, CC_SHA512_DIGEST_LENGTH, digest);
    }
    
    [self printBuffer:digest];
    if (objType == 0) {
        NSMutableString *output = [NSMutableString stringWithCapacity:desLen * 2];
        for(int index = 0; index < desLen; index++) {
            [output appendFormat:@"%02x", digest[index]];
        }
        return [output copy];
    }
    if (objType == 1) {
        return [[NSData alloc]initWithBytes:digest length:desLen];
    }
    return nil;
}
#pragma mark - base64
+ (NSData *_Nullable)base64Bytes:(const char *)bytes len:(int)len {
    NSData *data = [NSData dataWithBytes:bytes length:len];
    return [self base64Data:data];
}
    
+ (NSData *_Nullable)base64Data:(NSData *)data {
    if (data.length > 0) {
        NSData *desData = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self printBuffer:desData.bytes];
        return data;
    }
    return nil;
}
    
+ (NSData *_Nullable)base64String:(NSString *)str {
    if (str.length > 0) {
        NSData *base64Data = [str dataUsingEncoding:NSUTF8StringEncoding];
        return [self base64Data:base64Data];
    }
    return nil;
}

#pragma mark - xor
+ (NSString *)xorWithString:(NSString *)str withPrivate:(NSString *)privateStr {
    NSInteger length = str.length;
    if (length > 0) {
        NSInteger privateLen = privateStr.length;
        const char *privateBuffer = [privateStr UTF8String];
        const char *strBuffer = [str UTF8String];
        
        NSMutableData *encryptData = [NSMutableData dataWithCapacity:length];
        for (NSInteger index = 0; index < length; index++) {
            NSInteger privateIndex = index % privateLen;
            Byte by = (Byte)(privateBuffer[privateIndex] ^ strBuffer[index]);
            [encryptData appendBytes:&by length:1];
        }
        [self printBuffer:encryptData.bytes];
        return [[NSString alloc]initWithData:encryptData encoding:NSASCIIStringEncoding];
    }
    return nil;
}
#pragma mark - print
+ (void)printBuffer:(unsigned char *)buf {
    NSInteger len = strlen(buf);
    for (NSInteger index = 0; index < len; index++) {
        printf(" %c ", buf[index]);
    }
    printf("\n");
}
@end
