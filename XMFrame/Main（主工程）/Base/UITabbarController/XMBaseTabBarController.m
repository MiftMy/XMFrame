//
//  XMBaseTabBarController.m
//  XMFrame
//
//  Created by Mifit on 2019/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMBaseTabBarController.h"

@interface XMBaseTabBarController ()

@end

@implementation XMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - orientation
/// 是否跟随屏幕旋转
- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

/// 支持旋转的方向有哪些
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

/// 控制 vc present进来的横竖屏和进入方向 ，支持的旋转方向必须包含改返回值的方向 （详细的说明见下文）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
@end
