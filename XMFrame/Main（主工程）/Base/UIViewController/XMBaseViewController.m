//
//  XMBaseViewController.m
//  XMFrame
//
//  Created by 梁小迷 on 19/2/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMBaseViewController.h"
#import "UIColor+XMTools.h"
#import "XMConst.h"
#import "MBProgressHUD.h"
#import "XMInfoAlert.h"

@interface XMBaseViewController ()
@property (nonatomic, assign) BOOL isViewDidAppear;
//@property (nonatomic, strong) UIColor *supperNavColor;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation XMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.supperNavColor = self.navigationController.navigationBar.backgroundColor;
    self.isViewDidAppear = NO;
    self.enableRotation = YES;
    self.suppertsOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    self.view.backgroundColor = [UIColor colorWithHexString:WeakBackgroundColor];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (self.presentOrientation != UIDeviceOrientationUnknown) {
        [self rotationDevice:UIInterfaceOrientationUnknown];
        [self rotationDevice:self.presentOrientation];
    }
}

- (void)dealloc {
//    self.navigationController.navigationBar.backgroundColor = self.supperNavColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isViewDidAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.isViewDidAppear = NO;
}

- (void)setPresentOrientation:(UIInterfaceOrientation)presentOrientation {
    if (_presentOrientation != presentOrientation) {
        _presentOrientation = presentOrientation;
        [self rotationDevice:self.presentOrientation];
    }
}

#warning 需要自己给图片
- (void)whiteBackItem {
//    [self backImage:whiteImage];
}

#warning 需要自己给图片
- (void)blackBackItem {
//    [self backImage:blackImage];
}

- (void)toastMsg:(NSString *)msg {
    // 吐司
    UIView *view = [UIApplication sharedApplication].delegate.window;
    if ([NSThread currentThread].isMainThread) {
        [XMInfoAlert showInfo:msg bgColor:[UIColor lightGrayColor].CGColor inView:view vertical:0.5];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XMInfoAlert showInfo:msg bgColor:[UIColor lightGrayColor].CGColor inView:view vertical:0.5];
        });
    }
}

- (void)enableSwipeRightBack:(BOOL)enable {
    [self.navigationController.interactivePopGestureRecognizer setEnabled:enable];
}

- (void)showHUD:(NSString *)msg {
    // HUD
    if (self.hud) {
        [self.hud hideAnimated:NO];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = msg;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [self.view bringSubviewToFront:hud];
    self.hud = hud;
}

- (void)showHUD:(NSString *)msg duration:(NSTimeInterval)time {
    // HUD time
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = msg;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [self.view bringSubviewToFront:hud];
    [hud hideAnimated:YES afterDelay:time];
}

- (void)hidenHUD {
    // 隐藏hud
    [self.hud hideAnimated:YES];
}
#pragma mark - private
- (void)rotationDevice:(UIInterfaceOrientation)orientation {
    NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

#pragma mark - ratation

- (BOOL)shouldAutorotate {
    return self.enableRotation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (!self.enableRotation) {
        return [self maskFromPresent];
    } else {
        if (self.isViewDidAppear) {
            if (self.willRotationBlock) {
                return self.willRotationBlock();
            } else {
                [self updatePresentOrientation];
            }
            if (self.didRotationBlock) {
                self.didRotationBlock();
            }
        }
    }
    return self.suppertsOrientations;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSString *str =  NSStringFromCGSize(size);
    NSLog(@"Transition to size:%@", str);
}

/// 更新屏幕方向
- (void)updatePresentOrientation {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationPortraitUpsideDown:
            _presentOrientation = (UIInterfaceOrientation)deviceOrientation;
            break;
        default:
            _presentOrientation = UIInterfaceOrientationUnknown;
            break;
    }
}

/// 屏幕present转mask
- (UIInterfaceOrientationMask)maskFromPresent {
    switch (self.presentOrientation) {
        case UIDeviceOrientationPortrait:
            return UIInterfaceOrientationMaskPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return UIInterfaceOrientationMaskLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            return UIInterfaceOrientationMaskLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        case UIInterfaceOrientationUnknown:
            return UIInterfaceOrientationMaskPortrait;
            break;
        default:
            break;
    }
}

@end
