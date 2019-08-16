//
//  XMLoginApi.m
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMLoginApi.h"
#import "XMURL.h"

@interface XMLoginApi()
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@end

@implementation XMLoginApi
- (instancetype)initWithUserAccouont:(NSString *)user pwd:(NSString *)pwd {
    if (self = [super init]) {
        self.account = user;
        self.password = pwd;
    }
    return self;
}

- (NSString*)requestUrl {
    return [XMURL loginURL];
}

- (id)requestArgument {
    return @{@"account":self.account, @"pwd":self.password};
}

- (NSString*)responseClass {
    return @"XMLoginModel";
}
/*
 /// 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

 /// 请求返回类型
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}
*/
@end
