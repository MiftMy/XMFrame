//
//  XMMacro.h
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 使用宏，预编译时候进行文本替换，不做类型检查，可能导致未知问题。大量宏辉z导致二进制文件变大。占用代码段空间。
 */
NS_ASSUME_NONNULL_BEGIN

/// 非0，则使用黑魔法实现Foundation安全, 不然自己使用safe方法。


/// weak or strong target
#define WeakTarget(weakSelf)  (__weak __typeof(self) weakSelf = self;)
#define StrongTarget(strongSelf)  (__strong __typeof(self) strongSelf = self;)


/// NSUserDefault
#define UserDefaults [NSUserDefaults standardUserDefaults]

/// 字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqual:nil] || ([str length]<=0))

/// log
#ifdef DEBUG
    #define MLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define MLog(...)
#endif

NS_ASSUME_NONNULL_END
