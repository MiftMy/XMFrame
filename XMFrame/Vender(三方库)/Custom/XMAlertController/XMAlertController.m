//
//  XMAlertController.m
//  XMFrame
//
//  Created by Mifit on 2019/6/12.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import "XMAlertController.h"

@interface XMAlertAction ()
@property (nullable, nonatomic) NSString *title;
@property (nullable, nonatomic) UIImage *image;
@property (nonatomic) UIAlertActionStyle style;
@end

@implementation XMAlertAction
- (instancetype)initWithTitle:(nullable NSString *)title image:(UIImage *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler {
    if (self = [super init]) {
        self.title = title;
        self.image = image;
        self.style = style;
    }
    return self;
}

+ (instancetype)actionWithTitle:(nullable NSString *)title image:(UIImage *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler {
    XMAlertAction * action = [[XMAlertAction alloc]initWithTitle:title image:image style:style handler:handler];
    return action;
}
@end

@interface XMAlertController ()
@property (nonatomic) UIAlertControllerStyle preferredStyle;
@property (nonatomic) NSMutableArray<XMAlertAction *> *innerActions;
@property (nonatomic) NSMutableArray *btns;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation XMAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [self updateFrame];
}

- (void)updateFrame {
    CGSize size = self.view.bounds.size;
    CGFloat height = self.actions.count * self.itemHeight;
    CGRect rect = CGRectMake(0, size.height-height-40, size.width, height);
    self.bgView.frame = rect;
    
    CGFloat space = 1.0f;
    for (NSInteger index = 0; index < self.btns.count; index++) {
        UIButton *btn = self.btns[index];
        CGRect rect = CGRectMake(0, (self.itemHeight+space) * btn.tag, size.width, self.itemHeight);
        if (index == self.btns.count-1) {
            rect.origin.y += 4;
        }
        btn.frame = rect;
    }
}

#pragma mark - private
- (void)setupUI {
    self.view.backgroundColor = [UIColor clearColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:view];
    
    CGSize size = self.view.bounds.size;
    CGFloat height = self.actions.count * self.itemHeight;
    CGRect rect = CGRectMake(0, size.height-height-40, size.width, height);
    self.bgView.frame = rect;
    
    NSInteger btnTag = 0;
    for (XMAlertAction *action in self.innerActions) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:action.title forState:UIControlStateNormal];
        if (action.style == UIAlertActionStyleCancel) {
            [btn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setImage:action.image forState:UIControlStateNormal];
        btn.tag = btnTag;
        [view addSubview:btn];
        [self.btns addObject:btn];
        btnTag++;
    }
}

#pragma mark - tableview

#pragma mark - public
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)msg {
    if (self = [super init]) {
        self.alertTitle = title;
        self.message = msg;
        self.itemHeight = 50;
    }
    return self;
}
//- (instancetype)initWithTitle:(NSString *)title message:(NSString *)msg style:(UIAlertControllerStyle)style {
//    if (self = [super init]) {
//        self.alertTitle = title;
//        self.message = msg;
//        self.preferredStyle = style;
//        self.itemHeight = 50;
//    }
//    return self;
//}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    XMAlertController *vc = [[XMAlertController alloc]initWithTitle:title message:message];
    return vc;
}
//+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
//    XMAlertController *vc = [[XMAlertController alloc]initWithTitle:title message:message style:preferredStyle];
//    return vc;
//}

- (void)addAction:(XMAlertAction *)action {
    [self.innerActions addObject:action];
}

- (NSArray<XMAlertAction *> *)actions {
    return self.innerActions;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
