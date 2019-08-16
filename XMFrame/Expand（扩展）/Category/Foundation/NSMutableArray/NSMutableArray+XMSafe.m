//
//  NSMutableArray+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSMutableArray+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSMutableArray (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //    NSError *error;
        // __NSArrayM : [[NSMutableArray alloc]init] 返回的对象
        // __NSPlaceholderArray : [NSMutableArray alloc] 返回的对象
        
        //    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:) error:&error];
        //    [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndexM:) error:&error]; // 不使用
        
        //    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safe_insertObject:atIndex:) error:&error];
        //    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safe_removeObjectAtIndex:) error:&error];
        //    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safe_replaceObjectAtIndex:withObject:) error:&error];
        //    [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:@selector(initWithCapacity:) withMethod:@selector(safe_initWithCapacity:) error:&error];
        
        
        
        [objc_getClass("__NSArrayM")swizzledInstanceOrgSel:@selector(objectAtIndex:) altSel:@selector(safe_objectAtIndex:)];
        [objc_getClass("__NSArrayM")swizzledInstanceOrgSel:@selector(insertObject:atIndex:) altSel:@selector(safe_insertObject:atIndex:)];
        [objc_getClass("__NSArrayM")swizzledInstanceOrgSel:@selector(removeObjectAtIndex:) altSel:@selector(safe_removeObjectAtIndex:)];
        [objc_getClass("__NSArrayM")swizzledInstanceOrgSel:@selector(replaceObjectAtIndex:withObject:) altSel:@selector(safe_replaceObjectAtIndex:withObject:)];
        [objc_getClass("__NSPlaceholderArray")swizzledInstanceOrgSel:@selector(initWithCapacity:) altSel:@selector(safe_initWithCapacity:)];
    });
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) { // index不在安全范围
        NSAssert(NO, @"%@ %s 数组访问越界(count:%ld index:%ld)", [self class], __FUNCTION__, self.count, index);
        return nil;
    }
#if kMifitRuntimeSwizzled
    return [self safe_objectAtIndex:index];
#else
    return [self objectAtIndex:index];
#endif
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) { // index不在安全范围
        NSAssert(NO, @"%@ %s 数组插入越界(count:%ld index:%ld)", [self class], __FUNCTION__, self.count, index);
    } else {
        if (!anObject) {
            NSAssert(NO, @"%@ %s Object为nil", [self class], __FUNCTION__);
        } else {
#if kMifitRuntimeSwizzled
            [self safe_insertObject:anObject atIndex:index];
#else
            [self insertObject:anObject atIndex:index];
#endif
        }
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSAssert(NO, @"%@ %s 数组删除对象越界(count:%ld index:%ld)", [self class], __FUNCTION__, self.count, index);
    } else {
#if kMifitRuntimeSwizzled
        [self safe_removeObjectAtIndex:index];
#else
        [self removeObjectAtIndex:index];
#endif
    }
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= self.count) { // index不在安全范围
        NSAssert(NO, @"%@ %s 数组交换越界(count:%ld index:%ld)", [self class], __FUNCTION__, self.count, index);
    } else {
        if (!anObject) {
            NSAssert(NO, @"%@ %s Object为nil", [self class], __FUNCTION__);
        } else {
#if kMifitRuntimeSwizzled
            [self safe_replaceObjectAtIndex:index withObject:anObject];
#else
            [self replaceObjectAtIndex:index withObject:anObject];
#endif
        }
    }
}

- (instancetype)safe_initWithCapacity:(NSInteger)capacity {
    if (capacity < 0) {
        NSAssert(NO, @"%@ %s 数组大小小于0(capacity:%ld)", [self class], __FUNCTION__, capacity);
        capacity = 0;
    }
#if kMifitRuntimeSwizzled
    return [self safe_initWithCapacity:capacity];
#else
    return [self initWithCapacity:capacity];
#endif
}
@end
