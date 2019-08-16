//
//  main.m
//  XMFrame
//
//  Created by Mifit on 2019/1/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// 越狱防护
static __inline__ __attribute__((always_inline)) int anti_tweak()
{
    uint8_t lmb[] = {'S', 'u', 'b', 's', 't', 'r', 'a', 't', 'e', '/', 'D', 'y', 'n', 'a', 'm', 'i', 'c', 0, };
    NSString *dir = [NSString stringWithFormat:@"/%@/%@%s%@", @"Library", @"Mobile", lmb, @"Libraries"];
    NSArray *dirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    NSArray *plistFiles = [dirFiles filteredArrayUsingPredicate:
                           [NSPredicate predicateWithFormat:
                            [NSString stringWithFormat:@"%@ %@%@ '.%@%@'",@"self", @"EN", @"DSWITH", @"pli", @"st"]]];
    int cnt = 0;
    for (NSString *file in plistFiles) {
        NSString *filePath = [dir stringByAppendingPathComponent:file];
        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (fileContent && [fileContent rangeOfString:[[NSBundle mainBundle] bundleIdentifier]].location != NSNotFound) {
            cnt ++;
        }
    }
    // 返回有针对本 app 的 tweak 数量，为 0 说明没有
    return cnt;
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (anti_tweak() > 0) {
            exit(0);
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
