//
//  NSFileManager+XMTools.h
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (XMTools)
+ (BOOL)deleteFileIfExist:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
