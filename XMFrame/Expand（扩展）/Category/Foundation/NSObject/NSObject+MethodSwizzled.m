//
//  NSObject+MethodSwizzled.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSObject+MethodSwizzled.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzled)
+ (void)swizzledInstanceOrgSel:(SEL)orgSel altSel:(SEL)altSel  {
    Method origMethod = class_getInstanceMethod(self, orgSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    
    class_addMethod(self, orgSel, class_getMethodImplementation(self, orgSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));

    // 此处两个参数不能使用前面的origMethod和altMethod，不知道为什么
    method_exchangeImplementations(class_getInstanceMethod(self, orgSel), class_getInstanceMethod(self, altSel));
}

/*
 Class class = NSClassFromString(@"__NSArrayI");
 Method objAtIndex = class_getInstanceMethod(class, @selector(objectAtIndex:));
 Method objAtIndexCheck = class_getInstanceMethod(class, @selector(objAtIndexCheck:));
 
 BOOL didAddMethod = class_addMethod([self class], @selector(objAtIndexCheck:), method_getImplementation(objAtIndexCheck), method_getTypeEncoding(objAtIndexCheck));
 
 if (didAddMethod) {
    class_replaceMethod([self class], @selector(objAtIndexCheck:), method_getImplementation(objAtIndex), method_getTypeEncoding(objAtIndex));
 } else {
 method_exchangeImplementations(objAtIndex, objAtIndexCheck);
 }
 */

+ (void)swizzledClassOrgSel:(SEL)orgSel altSel:(SEL)altSel {
    Method origMethod = class_getClassMethod(self, orgSel);
    Method altMethod = class_getClassMethod(self, altSel);
    
    class_addMethod(self, orgSel, class_getMethodImplementation(self, orgSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
    
    // 此处两个参数不能使用前面的origMethod和altMethod，不知道为什么
    method_exchangeImplementations(class_getClassMethod(self, orgSel), class_getClassMethod(self, altSel));
}
@end
