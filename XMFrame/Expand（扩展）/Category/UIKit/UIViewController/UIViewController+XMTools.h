//
//  UIViewController+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XMTools)
/// 头部刘海高度
- (CGFloat)fringeTopHeight;

/// 底部刘海高度
- (CGFloat)fringeBottomHeight;

/// 跳转到设置。iOS 8-9，跳到app内设置，内容有网络、麦克风、摄像头等权限开关设置；iOS 10以上跳到系统设置。
- (void)jumpToAppSetting;

/// 隐藏键盘
- (void)hideKeyboard;

#pragma mark - navigation and status bar
/// 导航栏背景透明，包括状态栏
- (void)clearNavBar;

/// 是否因此导航栏
- (void)hiddenNavBar:(BOOL)isHidden;

/// 导航栏title颜色
- (void)navTitleColor:(UIColor *)color;

/// 导航栏title的attribute，如：NSFontAttributeName、NSForegroundColorAttributeName
- (void)navTitleAttribute:(NSDictionary *)attribute;

/// 导航栏右边添加文字item
- (void)addRightTitle:(NSString *)title;

/// 导航栏右边添加图片item
- (void)addRightImage:(UIImage *)image;

/// 导航栏右边添加item
- (void)addRightItem:(UIBarButtonItem *)item;

/// 清除返回title，
- (void)clearBackTitle;

/// 设置返回按钮图片
- (void)backImage:(UIImage *)img;

/// 设置导航栏背景色。颜色可以带透明度。
- (void)navBackgroundColor:(UIColor *)bgColor;

/// 导航栏透明度，字体也会跟着透明
- (void)navBarAlpha:(CGFloat)alpha;

/// 设置状态栏颜色。颜色可以带透明度。
- (void)statusBarBackgroundColor:(UIColor *)color;

/// 状态背景栏透明度，字体也会跟着透明
- (void)statusBarAlpha:(CGFloat)alpha;

#pragma mark - system alert
/// 显示一个警告
- (void)showAlertTitle:(nullable NSString *)title msg:(nullable NSString *)msg  completedBlock:(nullable void(^)(void))cBlock;

/// 显示两个按钮的alert，按钮默认显示：取消、确定。
- (void)showAlertTitle:(nullable NSString *)title msg:(nullable NSString *)msg cancelBlock:(nullable void(^)(void))cBlock sureBlock:(nullable void(^)(void))sBlock;

/// 同上，但是显示按钮title自定，传nil时默认确定。
- (void)showAlertTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitles:(nullable NSArray *)actiontitles actionBlock:(nullable void(^)(NSInteger actionIndex))cBlock;

/// 显示多个按钮的action，自动添加取消
- (void)showActionSheet:(nullable NSString *)title msg:(nullable NSString *)msg actionTitles:(nullable NSArray *)subTitles actionBlock:(nullable void(^)(NSInteger actionIndex))cBlock;

@end

NS_ASSUME_NONNULL_END
