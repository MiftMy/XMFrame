//
//  XMBaseApi.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>
NS_ASSUME_NONNULL_BEGIN

@interface XMBaseApi : YTKRequest
/// 是否解析返回数据，默认YES，解析。
@property (nonatomic, assign)BOOL isParser;

/// 开始请求。请求成功，error为nil，失败不为nil。
- (void)starRequestWithCompletionBlock:(void(^)(NSError *error, id response))block;
@end

NS_ASSUME_NONNULL_END
