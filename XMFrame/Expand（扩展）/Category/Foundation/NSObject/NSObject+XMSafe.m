//
//  NSObject+XMSafe.m
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSObject+XMSafe.h"
#import <objc/runtime.h>

//static const void *mifit_store_dictionary = &mifit_store_dictionary;

@implementation NSObject (XMSafe)

//+ (BOOL)resolveInstanceMethod:(SEL)selector {
//    NSString *selectorString = NSStringFromSelector(selector);
//    if([selectorString hasPrefix:@"set"]) {// 向类中动态的添加方法，第三个参数为函数指针，指向待添加的方法。最后一个参数表示待添加方法的“类型编码”
//        class_addMethod(self, selector,(IMP)autoDictionarySetter,"v@:@");return YES;
//    }
//    if ([selectorString hasPrefix:@"get"]) { // 可能是getter
//        class_addMethod(self, selector,(IMP)autoDictionaryGetter,"v@:@");return YES;
//    }
//    return NO;
//}
//
//- (NSMutableDictionary *)storeDictionary {
//    NSMutableDictionary *dic = objc_getAssociatedObject(self, mifit_store_dictionary);
//    if (!dic) {
//        NSMutableDictionary *temDic = [NSMutableDictionary dictionary];
//        objc_setAssociatedObject(self, mifit_store_dictionary, temDic, OBJC_ASSOCIATION_RETAIN);
//        dic = temDic;
//    }
//    return dic;
//}
//
//id autoDictionaryGetter(id self, SEL _cmd) {
//    // 此时_cmd = (SEL)"date"
//    // Get the backing store from the object
//    NSMutableDictionary *backingStore = [self storeDictionary];//the key is simply the selector name
//    NSString *key = NSStringFromSelector(_cmd);//Return the value
//    return [backingStore objectForKey:key];
//}
//
//void autoDictionarySetter(id self, SEL _cmd, id value) {
//    // 此时_cmd = (SEL)"setDate："
//    // Get the backing store from the object
//    NSMutableDictionary *backingStore = [self storeDictionary];
//    /** The selector will be for example, "setDate:".     * We need to remove the "set",":" and lowercase the first letter of the remainder.*/
//    NSString *selectorString = NSStringFromSelector(_cmd);
//    NSMutableString *key = [selectorString mutableCopy];
//    // Remove the ':' at the end
//    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
//    // Remove the 'set' prefix
//    [key deleteCharactersInRange:NSMakeRange(0, 3)];
//    // Lowercase the first character
//    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
//    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
//    if(value) {
//        [backingStore setObject:value forKey:key];
//    } else {
//        [backingStore removeObjectForKey:key];
//    }
//}


#pragma mark  forwardingTargetForSelector
// 重写消息转发方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorStr = NSStringFromSelector(aSelector);
    NSLog(@"PROTECTOR: -[%@ %@]", [self class], selectorStr);
    NSLog(@"PROTECTOR: unrecognized selector \"%@\" sent to instance: %p", selectorStr, self);
    // 查看调用栈
    NSLog(@"PROTECTOR: call stack: %@", [NSThread callStackSymbols]);
    
    // 对保护器插入该方法的实现
    Class protectorCls = NSClassFromString(@"xm_Protector");
    if (!protectorCls) {
        protectorCls = objc_allocateClassPair([NSObject class], "xm_Protector", 0);
        objc_registerClassPair(protectorCls);
    }
    
    // 在该类里面添加方法
    class_addMethod(protectorCls, aSelector, [self safeImplementation:aSelector], [selectorStr UTF8String]);
    
    Class Protector = [protectorCls class];
    id instance = [[Protector alloc] init];
    
    return instance;
}

// 一个安全的方法实现
- (IMP)safeImplementation:(SEL)aSelector {
    IMP imp = imp_implementationWithBlock(^() {
                                              NSLog(@"PROTECTOR: %@ Done", NSStringFromSelector(aSelector));
                                          });
    return imp;
}

#pragma mark forwardInvocation:
- (void)sforwardInvocation:(NSInvocation *)anInvocation {
    NSString *key = NSStringFromSelector([anInvocation selector]);
}

- (NSMethodSignature *)smethodSignatureForSelector:(SEL)selector {
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0) {
        //动态造一个 setter函数
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        //动态造一个 getter函数
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

#pragma mark  doesNotRecognizeSelector
- (void)sdoesNotRecognizeSelector:(SEL)aSelector {
    NSException *exception = [NSException exceptionWithName:@"" reason:@"" userInfo:@{}];
//    @throw exception;
}

@end
