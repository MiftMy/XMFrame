//
//  XMWhiteButton.m
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMWhiteButton.h"
#import "UIColor+XMTools.h"
#import "UIImage+XMTools.h"

@implementation XMWhiteButton
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
    UIColor *colorNor = [UIColor colorWithHexString:@"#333333"];
    UIImage *imgNor = [UIImage imageWithColor:colorNor];
    [self setImage:imgNor forState:UIControlStateNormal];
    
    UIColor *colorHighlight = [UIColor colorWithHexString:@"#333333"];
    UIImage *imgHighlight = [UIImage imageWithColor:colorHighlight];
    [self setImage:imgHighlight forState:UIControlStateHighlighted];
    
    UIColor *colorDisable = [UIColor colorWithHexString:@"#999999"];
    UIImage *imgDisable = [UIImage imageWithColor:colorDisable];
    [self setImage:imgDisable forState:UIControlStateDisabled];
}


@end
