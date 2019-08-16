//
//  NSURL+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/26.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSURL+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSURL (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("NSURL")swizzledInstanceOrgSel:@selector(initWithString:relativeToURL:) altSel:@selector(safe_initWithString:relativeToURL:)];
        [objc_getClass("NSURL")swizzledInstanceOrgSel:@selector(initFileURLWithPath:) altSel:@selector(safe_initFileURLWithPath:)];
        [objc_getClass("NSURL")swizzledInstanceOrgSel:@selector(initFileURLWithPath:isDirectory:) altSel:@selector(safe_initFileURLWithPath:isDirectory:)];
        [objc_getClass("NSURL")swizzledInstanceOrgSel:@selector(initFileURLWithPath:relativeToURL:) altSel:@selector(safe_initFileURLWithPath:relativeToURL:)];
    });
}

- (instancetype)safe_initWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL {
    if (URLString) {
#if kMifitRuntimeSwizzled
        return [self safe_initWithString:URLString relativeToURL:baseURL];
#else
        return [self initWithString:URLString relativeToURL:baseURL];
#endif
    } else {
        NSAssert(NO, @"%@ %s str 为nil", [self class], __FUNCTION__);
        return nil;
    }
}

- (instancetype)safe_initFileURLWithPath:(NSString *)path {
    if (path) {
#if kMifitRuntimeSwizzled
        return [self safe_initFileURLWithPath:path];
#else
        return [self initFileURLWithPath:path];
#endif
    } else {
        NSAssert(NO, @"%@ %s path 为nil", [self class], __FUNCTION__);
        return nil;
    }
}

- (instancetype)safe_initFileURLWithPath:(NSString *)path isDirectory:(BOOL)isDir {
    if (path) {
#if kMifitRuntimeSwizzled
        return [self safe_initFileURLWithPath:path isDirectory:isDir];
#else
        return [self initFileURLWithPath:path isDirectory:isDir];
#endif
    } else {
        NSAssert(NO, @"%@ %s path 为nil", [self class], __FUNCTION__);
        return nil;
    }
}
- (instancetype)safe_initFileURLWithPath:(NSString *)path relativeToURL:(NSURL *)baseURL {
    if (path) {
#if kMifitRuntimeSwizzled
        return [self safe_initFileURLWithPath:path relativeToURL:baseURL];
#else
        return [self initFileURLWithPath:path relativeToURL:baseURL];
#endif
    } else {
        NSAssert(NO, @"%@ %s path 为nil", [self class], __FUNCTION__);
        return nil;
    }
}
@end
