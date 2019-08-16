//
//  XMLoginModel.m
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMLoginModel.h"

@implementation XMLoginModel
/// 名字修改映射。返回的id映射为ID
+ (NSDictionary*)mj_replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             };
}

/// 数组解析。list数组内容是MRRequirement
+ (NSDictionary*)mj_objectClassInArray {
    return @{
             @"list":@"OneModel",
             };
}
@end
