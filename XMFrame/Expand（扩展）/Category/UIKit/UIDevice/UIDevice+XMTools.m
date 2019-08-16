//
//  UIDevice+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UIDevice+XMTools.h"

#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AVFoundation/AVFoundation.h>
#import "Reachability.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (XMTools)
+ (BOOL)isPad {
    static dispatch_once_t onece;
    static BOOL pad;
    dispatch_once(&onece, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

+ (BOOL)isPhone {
    static dispatch_once_t onece;
    static BOOL phone;
    dispatch_once(&onece, ^{
        phone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    });
    return phone;
}

+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}


+ (BOOL)isFringe {
    BOOL fringe = NO;
    NSString *machineModel = [self machineModel];
    if ([machineModel hasPrefix:@"iPhone 11"]) { // ihpone xr xs xs_max
        fringe = YES;
    }
    if ([machineModel hasPrefix:@"iPhone 10,3"]) { // ihpone x
        fringe = YES;
    }
    if ([machineModel hasPrefix:@"iPhone 10,6"]) { // ihpone x
        fringe = YES;
    }
    return fringe;
}

// 网络类型，0：无网、1：2G、2：3G、3：4G、4：unkown、5：WIFI
+ (int)networkStatus {
#if 0
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int connect = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            connect = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            break;
        }
    }
#if DEBUG
    NSLog(@"----%d", connect);
#endif
    return connect;
#else
    int connect = 0;
    static Reachability *reach = nil;
    if (!reach) {
        reach = [Reachability reachabilityForInternetConnection];
    }
    NetworkStatus status = [reach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            connect = 0;
            break;
        case ReachableViaWiFi:
            connect = 5;
            break;
        case ReachableViaWWAN:
        {
            connect = 4;
            CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];    // 只能临时创建，static的容易出现获取不到currentRadioAccessTechnology
            NSString *radio = info.currentRadioAccessTechnology;
            if (radio) {
                const NSDictionary *dicTime = @{
                                                CTRadioAccessTechnologyEdge         : @1,
                                                CTRadioAccessTechnologyGPRS         : @1,
                                                CTRadioAccessTechnologyWCDMA        : @2,
                                                CTRadioAccessTechnologyHSDPA        : @2,
                                                CTRadioAccessTechnologyHSUPA        : @2,
                                                CTRadioAccessTechnologyCDMA1x       : @2,
                                                CTRadioAccessTechnologyCDMAEVDORev0 : @2,
                                                CTRadioAccessTechnologyCDMAEVDORevA : @2,
                                                CTRadioAccessTechnologyCDMAEVDORevB : @2,
                                                CTRadioAccessTechnologyeHRPD        : @2,
                                                CTRadioAccessTechnologyLTE          : @3,
                                                };
                NSNumber *num = [dicTime objectForKey:radio];
                if (num && [num isKindOfClass:NSNumber.class]) {
                    connect = num.intValue;
                }
            }
        }
            break;
    }
#if DEBUG
    NSLog(@"----%d", connect);
#endif
    return connect;
#endif
}


+ (NSString *)networkStatusDescription {
    int status = [self networkStatus];
    NSString *desc = @"";
    switch (status) {
        case 1:
            desc = @"2G";
            break;
        case 2:
            desc = @"3G";
            break;
        case 3:
            desc = @"4G";
            break;
        case 4:
            desc = @"LTE";
            break;
        case 5:
            desc = @"WIFI";
            break;
        default:
            desc = @"无网";
            break;
    }
    return desc;
}

+ (NSString *)networkInfo {
    return [NSString stringWithFormat:@"%@_%d",[self carrierName],[self networkStatus]];
}

+ (NSString *)carrierName {
    static NSString *_carrierName = nil;
    static CTTelephonyNetworkInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [CTTelephonyNetworkInfo new];
        info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier * _Nonnull carrier){
            if (carrier) {
                _carrierName = carrier.carrierName?:@"";
            }
        };
        CTCarrier *carrier = [info subscriberCellularProvider];
        _carrierName = carrier.carrierName?:@"";
    });
    return _carrierName;
}

+ (NSString*)iosVersion {
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - hard info
+ (XMDeviceType)deviceType {
    NSString *machineModel = [self machineModel];
    if ([machineModel hasPrefix:@"iPhone"]) {
        return XMDeviceTypeIPhone;
    }
    if ([machineModel hasPrefix:@"iPad"]) {
        return XMDeviceTypeIPad;
    }
    if ([machineModel hasPrefix:@"iPod"]) {
        return XMDeviceTypeIPod;
    }
    if ([machineModel hasPrefix:@"x86_64"]) {
        return XMDeviceTypeX86_64;
    }
    if ([machineModel hasPrefix:@"i386"]) {
        return XMDeviceTypeI386;
    }
    return XMDeviceTypeUnknown;
}

+ (NSUInteger)cpuCoresCount {
    return [[NSProcessInfo processInfo] processorCount];
}

+ (CGFloat)battery {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(batteryLevel)]) {
        
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        return [UIDevice currentDevice].batteryLevel * 100.;
    } else {
        return -1;
    }
}

+ (BOOL)charging {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateCharging) {
        return YES;
    } else {
        return NO;
    }
}

+ (CGFloat)volume {
    return [[AVAudioSession sharedInstance] outputVolume]*100.;
}

+ (CGFloat)brightness {
    return [UIScreen mainScreen].brightness * 100.;
}

+ (NSUInteger)totalMemory {
    return [NSProcessInfo processInfo].physicalMemory>>20;
}

+ (double)memoryUsage {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
    }
    
    /* Stats in bytes */
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * (natural_t)pagesize;
    natural_t mem_free = vm_stat.free_count * (natural_t)pagesize;
    natural_t mem_total = mem_used + mem_free;
    return (double)(mem_total - mem_free)/(double)mem_total*100.;
}

+ (uint64_t)totalDiskSpace {
    uint64_t totalSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return totalSpace;
}

+ (uint64_t)freeDiskSpace {
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    return totalFreeSpace;
}

+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

+ (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch1,7" : @"Apple Watch Series 1 42mm",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              
                              @"iPhone10,1" : @"iPhone 8 (A1863/A1906)",
                              @"iPhone10,2" : @"iPhone 8 Plus (A1864/A1898)",
                              @"iPhone10,3" : @"iPhone X (A1865/A1902)",
                              @"iPhone10,4" : @"iPhone 8 (A1905)",
                              @"iPhone10,5" : @"iPhone 8 Plus (A1897)",
                              @"iPhone10,6" : @"iPhone X (A1901)",
                              
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,4" : @"iPhone XS MAX",
                              @"iPhone11,6" : @"iPhone XS MAX",
                              @"iPhone11,8" : @"iPhone XR",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              
                              @"iPad7,1" : @"iPad Pro (12.9 inch 2nd gen WiFi)",
                              @"iPad7,2" : @"iPad Pro (12.9 inch 2nd gen Cellular)",
                              @"iPad7,3" : @"iPad Pro (10.5 inch WiFi)",
                              @"iPad7,4" : @"iPad Pro (10.5 inch Cellular)",
                              
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}
@end
