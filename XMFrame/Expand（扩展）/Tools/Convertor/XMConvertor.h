//
//  XMConvertor.h
//  XMFrame
//
//  Created by Mifit on 2019/2/23.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMConvertor : NSObject
/// NSDictionary 转 NSString
+ (NSString *)stringFromDictionary:(NSDictionary *)dic;
/// NSString 转 NSDictionary
+ (NSDictionary *)dictionaryFromString:(NSString *)jsonStr;

+ (NSTimeInterval)timeIntervalFromDate:(NSDate *)date;
+ (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString *)hexStringFromBinary:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
