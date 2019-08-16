//
//  NSFileManager+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "NSFileManager+XMTools.h"

@implementation NSFileManager (XMTools)
+ (BOOL)deleteFileIfExist:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        [fileManager removeItemAtPath:filePath error:&error];
        if (!error) {
            return YES;
        }
        return NO;
    }
    return NO;
}
@end
