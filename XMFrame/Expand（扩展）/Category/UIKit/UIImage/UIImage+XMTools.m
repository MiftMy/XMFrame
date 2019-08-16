//
//  UIImage+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/1/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UIImage+XMTools.h"

@implementation UIImage (XMTools)
#pragma mark - 类方法
+ (UIImage *)captureWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    // IOS7及其后续版本
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    } else { // IOS7之前的版本
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+ (UIImage *)imageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 水印
+ (UIImage *)wateredImageName:(NSString *)bgImageName withMarkImageName:(NSString *)markName {
    
    UIImage *bgImage = [UIImage imageNamed:bgImageName];
    UIImage *waterImage = [UIImage imageNamed:markName];
    
    CGFloat scale = 0.5;
    CGFloat margin = 5;
    CGFloat waterW = bgImage.size.width * scale;
    CGFloat waterH = waterImage.size.height / waterImage.size.width * waterW;
    CGFloat waterX = (bgImage.size.width - waterW)/2 - margin;
    CGFloat waterY = (bgImage.size.height - waterH)/2 - margin;
    CGRect waterRect = CGRectMake(waterX, waterY, waterW, waterH);
    
    return [self wateredImage:bgImage withWaterImage:waterImage waterImageRect:waterRect];
}

+ (UIImage *)wateredImage:(UIImage *)image withWaterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect {
    if (!image && !waterImage) {
        return nil;
    }
    if (!waterImage) {
        return image;
    }
    //1.获取图片
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

+ (UIImage *)wateredImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributed:(NSDictionary * )attributed {
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


#pragma mark - 实例方法
//绘制图片圆角
- (UIImage *)drawCornerInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
