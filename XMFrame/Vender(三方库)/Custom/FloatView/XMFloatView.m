//
//  XMFloatView.m
//  Test
//
//  Created by Mifit on 2019/4/9.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMFloatView.h"

@interface XMFloatView ()

@end

@implementation XMFloatView
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

// 允许自动旋转
-(BOOL)shouldAutorotate{
    return NO;
}
// 横屏时是否将状态栏隐藏
-(BOOL)prefersStatusBarHidden{
    return NO;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

- (void)setupView {
    self.type = XMLeanTypeFloat;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    tapGR.cancelsTouchesInView = NO; // 解决和touches冲突问题
    [self addGestureRecognizer:tapGR];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showFront {
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
}

- (void)tapHandle:(UITapGestureRecognizer *)tap  {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.superview];
    [self changeLocation:pt];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.superview];
    [self changeLocation:pt];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.superview];
    [self changedEnd:pt];
    NSLog(@"......end......");
}

- (void)changeLocation:(CGPoint)pt {
    self.center = [self safeLocation:pt];
}

- (CGPoint)safeLocation:(CGPoint)pt {
    CGSize superSize = self.superview.bounds.size;
    CGSize size = self.bounds.size;
    CGFloat halfWidth = size.width/2;
    CGFloat halfHeight = size.height/2;
    if (pt.x < halfWidth) {
        pt.x = halfWidth;
    }
    if (pt.x > superSize.width-halfWidth) {
        pt.x = superSize.width - halfWidth;
    }
    
    if (pt.y < halfHeight) {
        pt.y = halfHeight;
    }
    if (pt.y > superSize.height-halfHeight) {
        pt.y = superSize.height - halfHeight;
    }
    return pt;
}

- (void)changedEnd:(CGPoint)pt {
    CGSize superSize = self.superview.bounds.size;
    CGFloat halfSuperWidth = superSize.width/2;
    CGFloat halfSuperHeight = superSize.height/2;
    
    CGSize size = self.bounds.size;
    CGFloat halfWidth = size.width/2;
    CGFloat halfHeight = size.height/2;
    
    CGPoint center = [self safeLocation:pt];

    BOOL isHorizontal = NO;
    if ( self.type == XMLeanTypeFloat ) {
        CGFloat minHor = MIN(center.x, superSize.width - center.x);
        CGFloat minVer = MIN(center.y, superSize.height - center.y);
        if (minHor < minVer) {
            isHorizontal = YES;
        }
    }
    if (self.type == XMLeanTypeHorizontal || (self.type == XMLeanTypeFloat && isHorizontal)) {
        if (center.x <= halfSuperWidth) {
            center.x = halfWidth;
        } else {
            center.x = superSize.width - halfWidth;
        }
    }
    if (self.type == XMLeanTypeVertical || (self.type == XMLeanTypeFloat && !isHorizontal)) {
        if (center.y <= halfSuperHeight) {
            center.y = halfHeight;
        } else {
            center.y = superSize.height - halfHeight;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.center = center;
    }];
}
@end
