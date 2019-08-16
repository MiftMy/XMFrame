//
//  XMLanguage.h
//  XMFrame
//
//  Created by Mifit on 2019/1/29.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define XMLocalizedString(key,alert)    ([XMLanguage localizeString:key])
#define XMResetLanguage(language)       ([XMLanguage resetCurrentLanguage:language])
#define XMCurrentLanguage               ([XMLanguage currentLanguage])

@interface XMLanguage : NSObject
/// 获取当前语言
+ (NSString *)currentLanguage;

/// 设置当前语言
+ (void)resetCurrentLanguage:(NSString *)language;

/// local str
+ (NSString *)localizeString:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
