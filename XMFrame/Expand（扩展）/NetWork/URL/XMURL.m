//
//  XMURL.m
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMURL.h"

@implementation XMURL
+ (NSString *)host {
#if DEBUG
    return @"http://192.168.1.122";
#else
    return @"http://www.myhost.com";
#endif
}

+ (NSString *)loginURL {
    return [[self host]stringByAppendingString:@"/login"];
}

+ (NSString *)logoutURL {
    return [[self host]stringByAppendingString:@"/logout"];
}

+ (NSString *)getUserInfoURL {
    return [[self host]stringByAppendingString:@"/userInfo"];
}

@end
