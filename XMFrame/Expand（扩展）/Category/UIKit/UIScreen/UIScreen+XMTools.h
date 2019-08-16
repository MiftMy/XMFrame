//
//  UIScreen+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (XMTools)
/// 屏幕宽高大小
+ (CGFloat)width;
+ (CGFloat)height;
+ (CGSize)orientationSize;
+ (CGSize)DPISize;


/// 检查是否指定设备设备尺寸
+ (BOOL)iPhone4SInch;
+ (BOOL)iPhone5SInch;
+ (BOOL)iPhone4_7Inch;
+ (BOOL)iPhone5_5Inch;
+ (BOOL)iPhoneXInch;
+ (BOOL)iPhoneXSInch;
+ (BOOL)iPhoneXRInch;
+ (BOOL)iPhoneXS_MaxInch;


/// 是否有刘海
+ (BOOL)hasFringe;


/// 安全范围顶部和底部
+ (CGFloat)fringeHeight;    // 刘海高度
+ (CGFloat)safeBottom;      // 底部高度
@end

NS_ASSUME_NONNULL_END
