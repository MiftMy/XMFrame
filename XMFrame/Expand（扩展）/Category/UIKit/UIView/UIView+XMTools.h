//
//  UIView+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMTools)
#pragma mark - frame
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


#pragma mark - 外观
/// 圆角 与边框不同步
- (void)xm_cornerRadius:(CGFloat)radius;

/// 边框 与圆角不同步
- (void)xm_border:(CGFloat)border borderColor:(UIColor *)color;

/// 同时设置边框和圆角
- (void)xm_cornerRadius:(CGFloat)radius border:(CGFloat)border borderColor:(UIColor *)color;

- (void)startRotation;

- (void)stopRotation;

#pragma mark - view
/// view所属VC
- (UIViewController *)viewController;

/// 从xib中加载
+ (instancetype)mr_loadFromNibWithNibName:(NSString*)nibName;

/// 移除所有子view
- (void)xm_removeAllSubViews;

/// 移除指定class 的子view
- (void)xm_removeSubView:(Class)cls;

/// view截图
- (UIImage *)captureView;
@end

NS_ASSUME_NONNULL_END
