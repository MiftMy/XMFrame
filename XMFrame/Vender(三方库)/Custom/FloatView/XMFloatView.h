//
//  XMFloatView.h
//  Test
//
//  Created by Mifit on 2019/4/9.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMLeanType) {
    XMLeanTypeFloat = 0,    // 四周最近依靠
    XMLeanTypeStand,        // 不依靠，手拖哪就哪
    XMLeanTypeHorizontal,   // 水平依靠
    XMLeanTypeVertical      // 垂直依靠
};
@interface XMFloatView : UIView

@property (nonatomic, assign) XMLeanType type;  // 默认四周最近依靠
@property (nonatomic, assign) UIEdgeInsets floatInsets; // 默认都是0

@property (nonatomic, copy) void(^tapBlock)(void);  // 点击事件回调

- (void)showFront;
@end

NS_ASSUME_NONNULL_END
