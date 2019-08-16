//
//  UIApplication+Tools.m
//  XMFrame
//
//  Created by Mifit on 2019/3/12.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UIApplication+Tools.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
//#import <CoreLocation/CoreLocation.h>

@implementation UIApplication (Tools)
// ios 6.0
- (XMPermissionAccess)accessToPhoto {
    XMPermissionAccess accessStatus = XMPermissionAccessNotDetermined;
    if (@available(iOS 10, *)) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];// ios 10
        accessStatus = (XMPermissionAccess)status;
    } else {
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus]; // ios 6-9
        accessStatus = (XMPermissionAccess)status;
    }
    return accessStatus;
}

- (XMPermissionAccess)accessToMicrophone {
    return [self accessToCaptureDeviceType:AVMediaTypeAudio];
}

- (XMPermissionAccess)accessToCamera {
    return [self accessToCaptureDeviceType:AVMediaTypeVideo];
}

// ios 7.0
- (XMPermissionAccess)accessToCaptureDeviceType:(AVMediaType)type {
    XMPermissionAccess accessStatus = XMPermissionAccessNotDetermined;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:type];
    accessStatus = (XMPermissionAccess)status;
    return accessStatus;
}

// ios 4.0
//- (XMPermissionAccess)accessToLocation {
//    XMPermissionAccess accessStatus = XMPermissionAccessNotDetermined;
//    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//    accessStatus = (XMPermissionAccess)status;
//    if (status >= 3) {
//        accessStatus = XMPermissionAccessAuthorized;
//    }
//    return accessStatus;
//}

#pragma mark - request access
- (void)requestAccessToPhotos:(void(^)(BOOL))block {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (block) {
            block(status >= 3);
        }
    }];
}

- (void)requestAccessToMicrophone:(void(^)(BOOL))block {
    [self requestAccessToDeviceType:AVMediaTypeAudio block:block];
}

- (void)requestAccessToCamera:(void(^)(BOOL))block {
    [self requestAccessToDeviceType:AVMediaTypeVideo block:block];
}

- (void)requestAccessToDeviceType:(AVMediaType)type block:(void(^)(BOOL))block {
    [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
        if (block) {
            block(granted);
        }
    }];
}

//- (void)requestAccessToLocation:(void(^)(BOOL))block {
//    [CLLocationManager requestWhenInUseAuthorization];
//}
@end
