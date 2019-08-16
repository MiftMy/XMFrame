//
//  XMBaseResponse.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMBaseResponse : NSObject
/// 返回code
@property (nonatomic, assign) NSInteger resultCode;
/// 返回结果信息
@property (nonatomic, copy) NSString *resultMessage;
@end

NS_ASSUME_NONNULL_END
