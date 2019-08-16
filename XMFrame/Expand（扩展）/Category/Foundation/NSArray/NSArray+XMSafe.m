//
//  NSArray+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSArray+XMSafe.h"
#import  <objc/runtime.h>
//#import "JRSwizzle.h"
#import "NSObject+MethodSwizzled.h"

@implementation NSArray (XMSafe)
+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
    
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL orgSel = @selector(objectAtIndex:);
        SEL altSel = @selector(safe_objectAtIndex:);
        
        //        NSError *error;
        //            [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:orgSel withMethod:altSel error:&error]; // [NSArray alloc] 返回的对象
        //        [objc_getClass("__NSArray0") jr_swizzleMethod:orgSel withMethod:altSel error:&error]; // [[NSArray alloc]init] 返回的对象， 没有元素的NSArray
        //        [objc_getClass("__NSArrayI") jr_swizzleMethod:orgSel withMethod:altSel error:&error]; // 多个元素的 NSArray
        //        [objc_getClass("__NSSingleObjectArrayI") jr_swizzleMethod:orgSel withMethod:altSel error:&error]; // 只有一个元素的 NSArray
        
        
        [objc_getClass("__NSArray0")swizzledInstanceOrgSel:orgSel altSel:altSel];
        [objc_getClass("__NSArrayI")swizzledInstanceOrgSel:orgSel altSel:altSel];
        [objc_getClass("__NSSingleObjectArrayI")swizzledInstanceOrgSel:orgSel altSel:altSel];
        
        //    [objc_getClass("__NSPlaceholderArray")swizzledInstanceOrgSel:@selector(initWithObjects:count:) altSel:@selector(xm_initWithObjects:count:)]; // // 改不了
    });
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (self.count <= index) { /// 不在安全范围
        NSAssert(NO, @"%@ %s 数组访问越界(count:%ld index:%ld)", [self class], __FUNCTION__, self.count, index);
        return nil;
    }
#if kMifitRuntimeSwizzled
    return [self safe_objectAtIndex:index];
#else
    return [self objectAtIndex:index];
#endif
}

//- (instancetype)xm_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSInteger)count {
//    return [xm_initWithObjects:objects count:count];
//}
@end
