//
//  NSDictionary+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSDictionary+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSDictionary (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // __NSDictionaryI      // 多个键值对
        // __NSSingleEntryDictionaryI   // 单个键值对
        // __NSDictionary0      // 空字典
        
        //    NSError *error;
        //    [objc_getClass("__NSPlaceholderDictionary") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // alloc 返回的对象 不使用
        //    [objc_getClass("__NSDictionary0") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // 空字典
        //    [objc_getClass("__NSSingleEntryDictionaryI") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // 单个值
        //    [objc_getClass("__NSDictionaryI") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // 多个值
        
            [objc_getClass("__NSDictionary0")swizzledInstanceOrgSel:@selector(setValue:forKey:) altSel:@selector(safe_setValue:forKey:)];
            [objc_getClass("__NSSingleEntryDictionaryI")swizzledInstanceOrgSel:@selector(setValue:forKey:) altSel:@selector(safe_setValue:forKey:)];
            [objc_getClass("__NSDictionaryI")swizzledInstanceOrgSel:@selector(setValue:forKey:) altSel:@selector(safe_setValue:forKey:)];
    });
}

- (void)safe_setValue:(id)value forKey:(NSString *)key {
    if (!value) {
        NSAssert(NO, @"%@ %s 设置值为空", [self class], __FUNCTION__);
    } else {
        if ([self valueForKey:key]) {
#if kMifitRuntimeSwizzled
            [self safe_setValue:value forKey:key];
#else
            [self setValue:value forKey:key];
#endif
        } else {
            NSAssert(NO, @"%@ %s 无此key：%@", [self class], __FUNCTION__, key);
        }
    }
}

@end
