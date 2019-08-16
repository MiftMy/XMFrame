//
//  XMPermission.h
//  XMFrame
//
//  Created by 梁小迷 on 7/7/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#ifndef XMPermission_h
#define XMPermission_h

typedef NS_ENUM(NSInteger, XMPermissionType) {
    XMPermissionTypePhotos,         // ALAssetsLibrary PHPhotoLibrary
    XMPermissionTypeMicrophone,     // AVCaptureDevice
    XMPermissionTypeCamera,         // AVCaptureDevice
    XMPermissionTypeLocation,       // CLLocationManager
    XMPermissionTypeBluetoothLE,    // CBCentralManager
    XMPermissionTypeCalendar,       // EKEventStore
    XMPermissionTypeMotion          //
};

typedef NS_ENUM(NSInteger, XMPermissionAccess) {
    XMPermissionAccessNotDetermined = 0,    // 未询问过
    XMPermissionAccessRestricted,           // 受限制
    XMPermissionAccessDenied,               // 拒绝
    XMPermissionAccessAuthorized,           // 同意
    XMPermissionAccessUnsupported           // 不支持，如设备损坏、当前设备没有
};

#endif /* XMPermission_h */
