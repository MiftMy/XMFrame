
//
//  UIViewController+XMTools.m
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UIViewController+XMTools.h"

@implementation UIViewController (XMTools)
- (CGFloat)fringeTopHeight {
    return 24;
}

- (CGFloat)fringeBottomHeight {
    return 34;
}

- (void)jumpToAppSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        CGFloat currVertion = [[[UIDevice currentDevice]systemVersion] floatValue];
        if (currVertion >= 10.0) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (UIImage *)imageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - navigation
- (void)clearNavBar {
    //导航栏透明
    self.navigationController.navigationBar.translucent = true;
    UIColor *clearColor = [UIColor clearColor];
    UIImage *image = [self imageWithColor:clearColor];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
}

- (void)hiddenNavBar:(BOOL)isHidden{
    self.navigationController.navigationBar.hidden = isHidden;
}

- (void)navTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,nil]];
}

- (void)navTitleAttribute:(NSDictionary *)attribute {
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

- (void)addRightTitle:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    [self addRightItem:item];
}

- (void)addRightImage:(UIImage *)image {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
    [self addRightItem:item];
}

- (void)addRightItem:(UIBarButtonItem *)item {
    NSMutableArray *rightItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [rightItems addObject:item];
    self.navigationItem.rightBarButtonItems = rightItems;
}

- (void)clearBackTitle {
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"list_next_down"];
}

- (void)backImage:(UIImage *)img {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(goback:)];
}

- (void)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navBackgroundColor:(UIColor *)bgColor {
    self.navigationController.navigationBar.backgroundColor = bgColor;
}

- (void)navBarAlpha:(CGFloat)alpha {
    self.navigationController.navigationBar.alpha = alpha;
}

- (void)statusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)statusBarAlpha:(CGFloat)alpha {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setAlpha:)]) {
        statusBar.alpha = alpha;
    }
}

#pragma mark - alert
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg completedBlock:(void(^)(void))cBlock {
    void(^block)(NSInteger) = ^(NSInteger actionIndex) {
        if (cBlock) {
            cBlock();
        }
    };
    [self showAlertType:UIAlertControllerStyleAlert title:title msg:msg actionTitles:@[@"确定"] actionBlock:block];
}

- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg  subTitle:(NSString *)subTitle completedBlock:(void(^)(void))cBlock {
    void(^block)(NSInteger) = ^(NSInteger actionIndex) {
        if (cBlock) {
            cBlock();
        }
    };
    [self showAlertType:UIAlertControllerStyleAlert title:title msg:msg actionTitles:@[subTitle] actionBlock:block];
}

- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg cancelBlock:(void(^)(void))cBlock sureBlock:(void(^)(void))sBlock {
    void(^block)(NSInteger) = ^(NSInteger actionIndex) {
        if (actionIndex == 0) {
            if (cBlock) {
                cBlock();
            }
        } else {
            if (sBlock) {
                sBlock();
            }
        }
    };
    [self showAlertType:UIAlertControllerStyleAlert title:title msg:msg actionTitles:@[@"取消", @"确定"] actionBlock:block];
}

- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)actiontitles actionBlock:(nullable void(^)(NSInteger actionIndex))aBlock {
    if (!actiontitles) {
        actiontitles = @[@"确定"];
    }
    [self showAlertType:UIAlertControllerStyleAlert title:title msg:msg actionTitles:actiontitles actionBlock:aBlock];
}

- (void)showActionSheet:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles actionBlock:(void(^)(NSInteger actionIndex))cBlock {
    [self showAlertType:UIAlertControllerStyleActionSheet title:title msg:msg actionTitles:subTitles actionBlock:cBlock];
}

- (void)showAlertType:(UIAlertControllerStyle)type title:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles actionBlock:(void(^)(NSInteger actionIndex))cBlock {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:type];
    NSInteger maxIndex = subTitles.count - 1;
    if (type == UIAlertControllerStyleActionSheet) {
        maxIndex = subTitles.count;
    }
    for (NSInteger indx = 0; indx <= maxIndex; indx++) {
        NSString *subTitle;
        UIAlertActionStyle style =  UIAlertActionStyleDefault;
        if (indx == subTitles.count && type == UIAlertControllerStyleActionSheet) {
            subTitle = @"取消";
            style = UIAlertActionStyleCancel;
        } else {
            subTitle = subTitles[indx];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:subTitle style:style handler:^(UIAlertAction * _Nonnull action) {
            if (cBlock) {
                NSInteger indx = 0;
                for (NSString *st in subTitles) {
                    if ([st isEqualToString:action.title]) {
                        break;
                    }
                    indx++;
                }
                cBlock(indx);
            }
        }];
        [vc addAction:action];
    }
    [self presentViewController:vc animated:YES completion:nil];
}
@end
