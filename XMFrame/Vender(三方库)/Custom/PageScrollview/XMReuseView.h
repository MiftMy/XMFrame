//
//  XMReuseView.h
//  Test
//
//  Created by Mifit on 2018/11/21.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMReuseView : UIView

@property (nonatomic, copy, readonly) NSString *identifier;

- (instancetype)initWithReuseIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
