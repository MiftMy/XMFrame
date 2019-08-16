//
//  NSString+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSString+XMTools.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMac.h>


@implementation NSString (XMTools)
- (NSUInteger)textByteLength:(NSString *)text {
    NSUInteger asciiLength = 0;
    for (NSUInteger index = 0; index < text.length; index++) {
        unichar uc = [text characterAtIndex:index];
        asciiLength += isascii(uc) ? 1:2;
    }
    return asciiLength;
}

//计算文本高度
- (CGFloat)heightForFont:(UIFont *)font withinSize:(CGSize)size {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

- (CGFloat)heightForFont:(UIFont *)font withinSize:(CGSize)size style:(NSMutableParagraphStyle *)style {
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize contentSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin)
                                           attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil].size;
    return contentSize.height;
}

+ (NSString *)reverseAllString:(NSString *)allstring findString:(NSString *)findString{
    if (!allstring.length&&!findString.length) {
        return allstring;
    }
    NSRange range =  [allstring rangeOfString:findString options:NSBackwardsSearch];
    return [allstring substringFromIndex:range.location+1];
}


- (NSString *_Nullable)md5 {
    if (self.length <= 0) {
        return nil;
    }
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (uint) strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int index = 0; index < CC_MD5_DIGEST_LENGTH; index++)
        [output appendFormat:@"%02x", md5Buffer[index]];
    
    return output;
}
    
- (NSString *_Nullable)sha1 {
    if (self.length <= 0) {
        return nil;
    }
//    const char* buf = [self cStringUsingEncoding:NSASCIIStringEncoding]; // 中文有错误
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int index = 0; index < CC_SHA1_DIGEST_LENGTH; index++) {
        [output appendFormat:@"%02x", digest[index]];
    }
    return output;
}
    
/// Hmac-SHA256加密算法
- (NSData *)hmacSha256WithKey:(NSString *)keyStr {
    if (self.length <= 0) {
        return nil;
    }
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    const char *cKey = [keyStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    NSData *data = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    free(digest);
    cKey = nil;
    return data;
}
    
- (NSData *_Nullable)base64Data {
    if (self.length > 0) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        return [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return nil;
}
    
- (NSString *_Nullable)base64String {
    if (self.length > 0) {
        NSData *base64Data = [self base64Data];
        return [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
    
- (NSString * _Nullable)unbase64String {
    if (self.length > 0) {
        NSData *desData = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [[NSString alloc]initWithData:desData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *_Nullable)xorWithString:(NSString *)privateStr {
    NSInteger length = self.length;
    if (length > 0) {
        NSInteger privateLen = privateStr.length;
        const char *privateBuffer = [privateStr UTF8String];
        const char *strBuffer = [self UTF8String];
    
        NSMutableData *encryptData = [NSMutableData dataWithCapacity:length];
        for (NSInteger index = 0; index < length; index++) {
            NSInteger privateIndex = index % privateLen;
            Byte by = (Byte)(privateBuffer[privateIndex] ^ strBuffer[index]);
            [encryptData appendBytes:&by length:1];
        }
        return [[NSString alloc]initWithData:encryptData encoding:NSASCIIStringEncoding];
    }
    return nil;
}
    
- (NSString *)urlEncode {
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":",
                            @"@", @"&", @"=", @"+", @"$", @",", @"!",
                            @"'", @"(", @")", @"*", @"-", nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A",
                             @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21",
                             @"%27", @"%28", @"%29", @"%2A", @"%2D", nil];
    
    NSUInteger len = [escapeChars count];
    NSString *tempStr = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    tempStr = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    if (tempStr == nil) {
        return nil;
    }
    
    NSMutableString *temp = [tempStr mutableCopy];
    for (int index = 0; index < len; index++) {
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:index]
                              withString:[replaceChars objectAtIndex:index]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}

- (BOOL)isEmpty {
    if (self.length <= 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNum {
    /*
     //手机号以13， 15，18开头，八个 \\d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\\\D])|(18[0,0-9]))\\\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     return [phoneTest evaluateWithObject:mobile];
     */
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[34578]([0-9]){9}"];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isPureCharacters {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}

//判断是否是纯数字
- (BOOL)isPureNum {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isPureSymbol {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    if (string.length == self.length) {
        return YES;
    }
    return NO;
}


+ (NSString *)homeDirectory {
    return NSHomeDirectory();
}

+ (NSString *)documentsDirectory {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)temporaryDirectory {
    return NSTemporaryDirectory();
}

+ (NSString *)cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
@end
