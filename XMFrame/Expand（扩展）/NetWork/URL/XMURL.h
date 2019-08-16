//
//  XMURL.h
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMURL : NSObject
/// 登录
+ (NSString *)loginURL;

/// 登出
+ (NSString *)logoutURL;

/// 获取用户信息
+ (NSString *)getUserInfoURL;

// more。。。
@end

NS_ASSUME_NONNULL_END
