//
//  XMScreenShot.h
//  XMFrame
//
//  Created by Mifit on 2019/5/31.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMScreenShot : NSObject

@property (nonatomic, copy) void (^didTakeScreenShotAction)(void);

- (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
