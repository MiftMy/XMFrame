//
//  UIFont+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (XMTools)
- (CGFloat)fontWeight;

/// 加粗
- (UIFont *)fontWithBold;

/// 斜体
- (UIFont *)fontWithItalic;

/// 加粗和斜体
- (UIFont *)fontWithBoldItalic;
@end

NS_ASSUME_NONNULL_END
