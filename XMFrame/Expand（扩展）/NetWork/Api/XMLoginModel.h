//
//  XMLoginModel.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLoginModel : XMBaseResponse
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *accessToken;
//@property (nonatomic, strong) NSArray *list;
//@property (nonatomic, strong) OtherModel *model;
@end

NS_ASSUME_NONNULL_END
