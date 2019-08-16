//
//  XMBaseApi.m
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMBaseApi.h"
#import "XMConst.h"
#import "XMBaseResponse.h"
#import <MJExtension.h>

@implementation XMBaseApi
- (NSDictionary*)requestHeaderFieldValueDictionary {

    NSMutableDictionary *clentInfo = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"Content-Type":@"application/json"
                                                                 }];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:kUserAccessToken];
    if (accessToken) {
        [clentInfo setObject:accessToken forKey:@"userToken"];
    }
    [self responseClass];
    return clentInfo;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)responseClass {
    return NSStringFromClass([XMBaseResponse class]);
}

- (void)starRequestWithCompletionBlock:(void(^)(NSError *error, id response))block {
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (block) {
            XMBaseResponse *responseObj = nil;
            if (self.isParser) {
                Class cls = NSClassFromString([self responseClass]);
                responseObj = [[cls alloc]mj_setKeyValues:request.responseJSONObject];
            } else {
                responseObj = request.responseObject;
            }
            if (responseObj.resultCode == 200) {
                block(nil, responseObj);
            } else {
                NSString *errorMsg;
                if (self.isParser) {
                    errorMsg = responseObj.resultMessage;
                } else {
                    errorMsg = @"正在拼命抢修中...";
                }
                NSError *error = [NSError errorWithDomain:@"XMResponseErrorDomain" code:responseObj.resultCode userInfo:@{@"msg":errorMsg}];
                block(error, responseObj);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (block) {
            block(request.error, nil);
        }
    }];
}

@end
