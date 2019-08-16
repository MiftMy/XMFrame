//
//  XMLoginApi.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLoginApi : XMBaseApi
- (instancetype)initWithUserAccouont:(NSString *)user pwd:(NSString *)pwd;
@end

NS_ASSUME_NONNULL_END
