//
//  UIScreen+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UIScreen+XMTools.h"

@implementation UIScreen (XMTools)
#pragma mark - width height size
+ (CGFloat)width {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)height {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)scale {
    return [UIScreen mainScreen].scale;
}

+ (CGSize)orientationSize {
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    CGSize temSize = [UIScreen mainScreen].bounds.size;
    if (isLand) {
        return CGSizeMake(temSize.height, temSize.width);
    } else {
        return temSize;
    }
}

+ (CGSize)DPISize {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

#pragma mark - device type
+ (BOOL)iPhone4SInch {
    return ([self height] == 480.0f) && ([self width] == 320.0f);
}

+ (BOOL)iPhone5SInch {
    return ([self height] == 568.0f) && ([self width] == 320.0f);
}

+ (BOOL)iPhone4_7Inch {
    return ([self height] == 667.0f) && ([self width] == 375.0f);
}

+ (BOOL)iPhone5_5Inch {
    return ([self height] == 736.0f) && ([self width] == 414.0f);
}

+ (BOOL)iPhoneXInch { // scale 2
    return ([self height] == 812.0f) && ([self width] == 375.0f) && ([self scale] == 2);
}

+ (BOOL)iPhoneXSInch { // scale 3
    return ([self height] == 812.0f) && ([self width] == 375.0f) && ([self scale] == 3);
}

+ (BOOL)iPhoneXRInch { //scale 2
    return ([self height] == 896.0f) && ([self width] == 414.0f) && ([self scale] == 2);
}

+ (BOOL)iPhoneXS_MaxInch { //scale 3
    return ([self height] == 896.0f) && ([self width] == 414.0f) && ([self scale] == 3);
}

#pragma mark - add
+ (BOOL)hasFringe {
    if ([self iPhoneXInch] || [self iPhoneXSInch] || [self iPhoneXRInch] || [self iPhoneXS_MaxInch]) {
        return YES;
    }
    return NO;
}

+ (CGFloat)fringeHeight {
    if ([self hasFringe]) {
        return 24.0f;
    } else {
        return 0.0f;
    }
}

+ (CGFloat)safeBottom {
    if ([self hasFringe]) {
        return 34.0f;
    } else {
        return 0.0f;
    }
}
@end
