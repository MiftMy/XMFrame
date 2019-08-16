//
//  XMRedButton.m
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMRedButton.h"
#import "UIColor+XMTools.h"
#import "UIImage+XMTools.h"

@implementation XMRedButton

- (instancetype)init {
    if (self = [super init]) {
        [self loadDefaultUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultUI];
    }
    return self;
}

- (void)loadDefaultUI {
    UIColor *colorNor = [UIColor colorWithHexString:@"#E4393C"];
    UIImage *imgNor = [UIImage imageWithColor:colorNor];
    [self setImage:imgNor forState:UIControlStateNormal];
    
    UIColor *colorHighlight = [UIColor colorWithHexString:@"#C93235"];
    UIImage *imgHighlight = [UIImage imageWithColor:colorHighlight];
    [self setImage:imgHighlight forState:UIControlStateHighlighted];
    
    UIColor *colorDisable = [UIColor colorWithHexString:@"#999999"];
    UIImage *imgDisable = [UIImage imageWithColor:colorDisable];
    [self setImage:imgDisable forState:UIControlStateDisabled];
}


@end
