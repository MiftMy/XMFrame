//
//  NSObject+MethodSwizzled.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 是否使用runtime交换系统方法达到安全访问。相关类有：NSString、NSMutableString、NSArray、NSMutableArray、NSDictionary、NSMutableDictionary、NSURL。
#define kMifitRuntimeSwizzled 0

@interface NSObject (MethodSwizzled)
+ (void)swizzledInstanceOrgSel:(SEL)orgSel altSel:(SEL)altSel;
+ (void)swizzledClassOrgSel:(SEL)orgSel altSel:(SEL)altSel;
@end

NS_ASSUME_NONNULL_END
