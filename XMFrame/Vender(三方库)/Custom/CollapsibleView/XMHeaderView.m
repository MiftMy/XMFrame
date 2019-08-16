//
//  XMHeaderView.m
//  Camera
//
//  Created by Mifit on 2019/3/23.
//  Copyright © 2019年 Tomy. All rights reserved.
//

#import "XMHeaderView.h"

@interface XMHeaderView()

@end

@implementation XMHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.backgroupTapBlck) {
        self.backgroupTapBlck();
    }
}
@end
