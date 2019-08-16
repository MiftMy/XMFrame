//
//  NSMutableDictionary+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSMutableDictionary+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSMutableDictionary (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //    NSError *error;
        //    [objc_getClass("__NSPlaceholderDictionary") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // alloc 返回的对象
        //    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(safe_setValue:forKey:) error:&error]; // 空字典
        //    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:) error:&error]; // 空字典
        
        [objc_getClass("__NSDictionaryM")swizzledInstanceOrgSel:@selector(setValue:forKey:) altSel:@selector(safe_setValue:forKey:)];
        [objc_getClass("__NSDictionaryM")swizzledInstanceOrgSel:@selector(setObject:forKey:) altSel:@selector(safe_setObject:forKey:)];
    });
}

- (void)safe_setValue:(id)value forKey:(NSString *)key {
    if (!key) {
        NSAssert(NO, @"%@ %s key为空", [self class], __FUNCTION__);
    } else {
#if kMifitRuntimeSwizzled
        [self safe_setValue:value forKey:key];
#else
        [self setValue:value forKey:key];
#endif
    }
}

- (void)safe_setObject:(id)value forKey:(NSString *)key {
    if (!key) {
        NSAssert(NO, @"%@ %s key为空", [self class], __FUNCTION__);
    } else {
#if kMifitRuntimeSwizzled
        [self safe_setObject:value forKey:key];
#else
        [self setObject:value forKey:key];
#endif
    }
}

@end
