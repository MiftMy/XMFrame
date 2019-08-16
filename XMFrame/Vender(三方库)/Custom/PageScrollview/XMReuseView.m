//
//  XMReuseView.m
//  Test
//
//  Created by Mifit on 2018/11/21.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMReuseView.h"

@interface XMReuseView()
@property (nonatomic, copy) NSString *identifier;
@end


@implementation XMReuseView

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

@end
