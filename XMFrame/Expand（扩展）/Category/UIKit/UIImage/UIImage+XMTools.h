//
//  UIImage+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/1/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XMTools)
/// view截图
+ (UIImage *)captureWithView:(UIView *)view;

/// 纯颜色转换图片
+ (UIImage *)imageWithColor:(UIColor*)color;

/// 给背景图加水印
+ (UIImage *)wateredImageName:(NSString *)bgImageName withMarkImageName:(NSString *)markName;

/// 在rect给图片image添加图片水印waterImage
+ (UIImage *)wateredImage:(UIImage *)image withWaterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

/// 给图片添加文字水印
+ (UIImage *)wateredImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributed:(NSDictionary * )attributed;


/// 图片圆角优化
- (UIImage *)drawCornerInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
