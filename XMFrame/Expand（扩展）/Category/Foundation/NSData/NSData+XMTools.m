//
//  NSData+XMTools.m
//  XMFrame
//
//  Created by 梁小迷 on 10/8/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSData+XMTools.h"

#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMac.h>

@implementation NSData (XMTools)
- (NSData *)md5 {
    // Create pointer to the string as UTF8
    NSInteger len = self.length;
    if (len <= 0) {
        return nil;
    }
    const char *orgBuf[len];
    [self getBytes:orgBuf range:NSMakeRange(0, len)];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(orgBuf, (uint) len, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    return [[NSData alloc]initWithBytes:md5Buffer length:len];
}
    
- (NSData *)sha1 {
    //    const char* buf = [self cStringUsingEncoding:NSASCIIStringEncoding]; // 中文有错误
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (unsigned int)self.length, digest);
    return [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}
    
- (NSData *)hmacSha256WithKey:(NSData *)key {
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    const char *cKey = [key bytes];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [self bytes], [self length], digest);
    NSData *data = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    free(digest);
    cKey = nil;
    return data;
}
    
- (NSData *)base64Data {
    if (self.length <= 0) {
        return nil;
    }
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
    
- (NSData *)unbase64Data {
    if (self.length <= 0) {
        return nil;
    }
    return [[NSData alloc]initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}
    
- (NSData *)oxrWithData:(NSData *)privateData {
    NSInteger length = self.length;
    if (length > 0) {
        NSInteger privateLen = privateData.length;
        char privateBuffer[privateLen];
        [privateData getBytes:privateBuffer range:NSMakeRange(0, privateLen)];
        char strBuffer[length];
        [self getBytes:strBuffer range:NSMakeRange(0, length)];
        
        NSMutableData *encryptData = [NSMutableData dataWithCapacity:length];
        for (NSInteger index = 0; index < length; index++) {
            NSInteger privateIndex = index % privateLen;
            Byte by = (Byte)(privateBuffer[privateIndex] ^ strBuffer[index]);
            [encryptData appendBytes:&by length:1];
        }
        return [encryptData copy];
    }
    return nil;
}
@end
