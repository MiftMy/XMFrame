//
//  NSString+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/25.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSString+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSString (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("NSPlaceholderString")swizzledInstanceOrgSel:@selector(initWithString:) altSel:@selector(safe_initWithString:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(stringByAppendingString:) altSel:@selector(safe_stringByAppendingString:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(substringFromIndex:) altSel:@selector(safe_substringFromIndex:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(substringToIndex:) altSel:@selector(safe_substringToIndex:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(substringWithRange:) altSel:@selector(safe_substringWithRange:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(stringByAppendingPathExtension:) altSel:@selector(safe_stringByAppendingPathExtension:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(stringByReplacingOccurrencesOfString:withString:) altSel:@selector(safe_stringByReplacingOccurrencesOfString:withString:)];
        [objc_getClass("__NSCFConstantString")swizzledInstanceOrgSel:@selector(characterAtIndex:) altSel:@selector(safe_characterAtIndex:)];
    });
}

- (instancetype)safe_initWithString:(NSString *)str {
    if (!str) {
        NSAssert(NO, @"%@ %s str 为nil", [self class], __FUNCTION__);
        str = @"";
    }
#if kMifitRuntimeSwizzled
    return [self safe_initWithString:str];
#else
    return [self initWithString:str];
#endif
}

- (unichar)safe_characterAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        NSAssert(NO, @"%@ %s 索引超出范围（length:%ld index:%ld）", [self class], __FUNCTION__, self.length, index);
        return ' ';
    }
#if kMifitRuntimeSwizzled
    return [self safe_characterAtIndex:index];
#else
    return [self characterAtIndex:index];
#endif
}

- (NSString *)safe_stringByAppendingString:(NSString *)str {
    if (str) {
#if kMifitRuntimeSwizzled
        return [self safe_stringByAppendingString:str];
#else
        return [self stringByAppendingString:str];
#endif
    } else {
        NSAssert(NO, @"%@ %s str 为nil", [self class], __FUNCTION__);
        return self;
    }
}

- (NSString *)safe_substringFromIndex:(NSUInteger)index {
    if (index > self.length) {
        index = self.length;
        NSAssert(NO, @"%@ %s 索引超出范围（length:%ld index:%ld）", [self class], __FUNCTION__, self.length, index);
    }
#if kMifitRuntimeSwizzled
    return [self safe_substringFromIndex:index];
#else
    return [self substringFromIndex:index];
#endif
}

- (NSString *)safe_substringToIndex:(NSUInteger)index {
    if (index > self.length) {
        index = self.length;
        NSAssert(NO, @"%@ %s 索引超出范围（length:%ld index:%ld）", [self class], __FUNCTION__, self.length, index);
    }
#if kMifitRuntimeSwizzled
    return [self safe_substringToIndex:index];
#else
    return [self substringToIndex:index];
#endif
}

- (NSString *)safe_substringWithRange:(NSRange)range {
    if (range.location+range.length > self.length) {
        NSAssert(NO, @"%@ %s range超出范围（length:%ld range.location:%ld range.length:%ld）", [self class], __FUNCTION__, self.length, range.location, range.length);
        return self;
    } else {
#if kMifitRuntimeSwizzled
        return [self safe_substringWithRange:range];
#else
        return [self substringWithRange:range];
#endif
    }
}

- (NSString *)safe_stringByAppendingPathExtension:(NSString *)str {
    if (str) {
#if kMifitRuntimeSwizzled
        return [self safe_stringByAppendingPathExtension:str];
#else
        return [self stringByAppendingPathExtension:str];
#endif
    }
    NSAssert(NO, @"%@ %s str 为nil", [self class], __FUNCTION__);
    return self;
}

- (NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    if (target) {
        if (replacement) {
#if kMifitRuntimeSwizzled
            return [self safe_stringByReplacingOccurrencesOfString:target withString:replacement];
#else
            return [self stringByReplacingOccurrencesOfString:target withString:replacement];
#endif
        } else {
            NSAssert(NO, @"%@ %s replacement 为nil", [self class], __FUNCTION__);
        }
    } else {
        NSAssert(NO, @"%@ %s target 为nil", [self class], __FUNCTION__);
    }
    return self;
}


@end
