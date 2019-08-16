//
//  UIApplication+Tools.h
//  XMFrame
//
//  Created by Mifit on 2019/3/12.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPermission.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Tools)

- (XMPermissionAccess)accessToPhoto;

- (XMPermissionAccess)accessToMicrophone;

- (XMPermissionAccess)accessToCamera;

//- (XMPermissionAccess)accessToLocation;


- (void)requestAccessToPhotos:(void(^)(BOOL))block;

- (void)requestAccessToMicrophone:(void(^)(BOOL))block;

- (void)requestAccessToCamera:(void(^)(BOOL))block;
@end

NS_ASSUME_NONNULL_END
