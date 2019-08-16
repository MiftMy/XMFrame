//
//  XMConvertor.m
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMConvertor.h"

@implementation XMConvertor
+ (NSString *)stringFromDictionary:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:0];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryFromString:(NSString *)jsonStr {
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSAssert(NO, @"json string解析失败：%@", err);
        return nil;
    }
    return dic;
}

+ (NSTimeInterval)timeIntervalFromDate:(NSDate *)date {
    return [date timeIntervalSince1970];
}

+ (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval {
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSString *)hexStringFromBinary:(NSData *)data {
    Byte buf[data.length];
    [data getBytes:buf range:NSMakeRange(0, data.length)];
    NSMutableString *hexStr = [[NSMutableString alloc]initWithCapacity:data.length*3-1];
    for (NSInteger index = 0; index < data.length; index++) {
        if (index == 0) {
            [hexStr appendFormat:@"%02x", buf[index]];
        } else {
            [hexStr appendFormat:@" %02x", buf[index]];
        }
    }
    return [hexStr copy];
}
@end
