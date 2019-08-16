//
//  UIDevice+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, XMDeviceType) {
    XMDeviceTypeUnknown,
    XMDeviceTypeIPhone = 1,
    XMDeviceTypeIPad = 2,
    XMDeviceTypeIPod = 3,
    XMDeviceTypeX86_64,
    XMDeviceTypeI386
};

@interface UIDevice (XMTools)
#pragma mark - software info
/// 是否iPad
+ (BOOL)isPad;

/// 是否iPhone
+ (BOOL)isPhone;

/// 是否模拟器
+ (BOOL)isSimulator;

/// 是否有刘海
+ (BOOL)isFringe;

/// 网络类型，0：无网、1：2G、2：3G、3：4G、4：unkown、5：WIFI
+ (int)networkStatus;

/// 网络状态描述
+ (NSString *)networkStatusDescription;

/// carrier与status一块
+ (NSString *)networkInfo;

/// 当前运营商
+ (NSString *)carrierName;

/// 系统版本
+ (NSString*)iosVersion;

#pragma mark - hard info
/// 设备类型
+ (XMDeviceType)deviceType;

/// cpu核数
+ (NSUInteger)cpuCoresCount;

/// 电池用量百分比
+ (CGFloat)battery;

/// 是否充电中 注：满格不是充电状态
+ (BOOL)charging;

/// 获取音量百分比
+ (CGFloat)volume;

/// 获取亮度百分比
+ (CGFloat)brightness;

/// 内存总大小
+ (NSUInteger)totalMemory;

/// 内存使用百分比
+ (double)memoryUsage;

/// 磁盘总大小 bytes
+ (uint64_t)totalDiskSpace;

/// 可用的剩余空间 bytes
+ (uint64_t)freeDiskSpace;

/// 设备型号，如iPhone7,2 对应设备是iPhone 6
+ (NSString *)machineModel;

/// 设备型号名称，如iPhone x
+ (NSString *)machineModelName;

@end

NS_ASSUME_NONNULL_END
