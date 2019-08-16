//
//  XMBaseViewModel.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMBaseViewModel : NSObject
/// 错误失败
@property (nonatomic, copy) void (^errorBlock)(NSError *error);


@end

NS_ASSUME_NONNULL_END
