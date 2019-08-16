//
//  XMBaseViewController.h
//  XMFrame
//
//  Created by 梁小迷 on 19/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+XMTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBaseViewController : UIViewController
/// 是否支持旋转
@property (nonatomic, assign) BOOL enableRotation;

/// 支持旋转的方向，默认除了上下颠倒。
@property (nonatomic, assign) UIInterfaceOrientationMask suppertsOrientations;

/// VC展示方向，默认跟随设备方向。enableRotation=NO，设置后不会变；enableRotation=YES，设置后会随屏幕变动。
@property (nonatomic, assign) UIInterfaceOrientation presentOrientation;

/// 将要转到哪个方向，不设置随设备方向。
@property (nonatomic, copy) UIInterfaceOrientationMask (^willRotationBlock)(void);

/// 已经转到那个方向
@property (nonatomic, copy) void (^didRotationBlock)(void);

/// 白色返回键
- (void)whiteBackItem;

/// 黑色返回键
- (void)blackBackItem;

/// 右滑返回禁止
- (void)enableSwipeRightBack:(BOOL)enable;

/// 吐司。会自己消失，且不影响用户操作。
- (void)toastMsg:(NSString *)msg;

/// hud，会阻碍用户操作。不会自己消失。
- (void)showHUD:(NSString *)msg;

/// 显示hud，time后自动消失
- (void)showHUD:(NSString *)msg duration:(NSTimeInterval)time;

/// 隐藏hud
- (void)hidenHUD;

@end

NS_ASSUME_NONNULL_END
