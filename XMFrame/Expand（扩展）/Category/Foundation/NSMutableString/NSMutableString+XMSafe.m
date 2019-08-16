//
//  NSMutableString+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/25.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSMutableString+XMSafe.h"
#import  <objc/runtime.h>
#import "NSObject+MethodSwizzled.h"

@implementation NSMutableString (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("NSPlaceholderMutableString")swizzledInstanceOrgSel:@selector(initWithString:) altSel:@selector(safe_initWithString:)];
        [objc_getClass("__NSCFString")swizzledInstanceOrgSel:@selector(replaceCharactersInRange:withString:) altSel:@selector(safe_replaceCharactersInRange:withString:)];
        [objc_getClass("__NSCFString")swizzledInstanceOrgSel:@selector(insertString:atIndex:) altSel:@selector(safe_insertString:atIndex:)];
        [objc_getClass("__NSCFString")swizzledInstanceOrgSel:@selector(deleteCharactersInRange:) altSel:@selector(safe_deleteCharactersInRange:)];
        [objc_getClass("__NSCFString")swizzledInstanceOrgSel:@selector(appendString:) altSel:@selector(safe_appendString:)];
    });
}

- (instancetype)safe_initWithString:(NSString *)aString {
    if (!aString) {
        NSAssert(NO, @"%@ %s string 为nil", [self class], __FUNCTION__);
        aString = @"";
    }
#if kMifitRuntimeSwizzled
    return [self safe_initWithString:aString];
#else
    return [self initWithString:aString];
#endif
}

- (void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (range.location + range.length > self.length) {
        NSAssert(NO, @"%@ %s 替换范围越界（length:%ld, loc:%ld length:%ld）", [self class], __FUNCTION__, self.length, range.location, range.length);
        range.location = range.location>self.length?self.length:range.location;
        range.length = self.length - range.location;
    }
#if kMifitRuntimeSwizzled
    [self safe_replaceCharactersInRange:range withString:aString];
#else
    [self replaceCharactersInRange:range withString:aString];
#endif
}

- (void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (aString) {
        if (loc > self.length) { // 可以等于
            NSAssert(NO, @"%@ %s 插入位置不在范围内（length:%ld, loc:%ld）", [self class], __FUNCTION__, self.length, loc);
        } else {
#if kMifitRuntimeSwizzled
            [self safe_insertString:aString atIndex:loc];
#else
            [self insertString:aString atIndex:loc];
#endif
        }
    } else {
        NSAssert(NO, @"%@ %s 插入string 为nil", [self class], __FUNCTION__);
    }
}

- (void)safe_deleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        NSAssert(NO, @"%@ %s 删除范围越界（length:%ld, loc:%ld length:%ld）", [self class], __FUNCTION__, self.length, range.location, range.length);
        range.location = range.location>self.length?self.length:range.location;
        range.length = self.length - range.location;
    }
#if kMifitRuntimeSwizzled
    [self safe_deleteCharactersInRange:range];
#else
    [self deleteCharactersInRange:range];
#endif
}

- (void)safe_appendString:(NSString *)aString {
    if (aString) {
#if kMifitRuntimeSwizzled
        [self safe_appendString:aString];
#else
        [self appendString:aString];
#endif
    } else {
        NSAssert(NO, @"%@ %s 插入string 为nil", [self class], __FUNCTION__);
    }
}
@end

