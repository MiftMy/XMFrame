//
//  XMCollectionView.m
//  XMFrame
//
//  Created by 梁小迷 on 7/7/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMCollectionView.h"

#import  <objc/runtime.h>
#import "NSObject+MethodSwizzled.h"

#import "UIColor+XMTools.h"
#import "XMConst.h"

@interface XMCollectionView ()
@property (nonatomic, strong) UIView *noneView;
@property (nonatomic, strong) UIView *noneNetworkView;
@property (nonatomic, strong) UIView *noneDataView;
@property (nonatomic, strong) UIView *noneAuthorizationView;
@property (nonatomic, strong) UIView *otherView;
@end

@implementation XMCollectionView

+ (void)load {
#if kMifitRuntimeSwizzled
    [self loadSafe];
#endif
}

+ (void)loadSafe {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("XMTableView") swizzledInstanceOrgSel:@selector(reloadData) altSel:@selector(xm_reloadData)];
    });
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadDefaultInfo];
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadDefaultInfo];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self loadDefaultInfo];
    }
    return self;
}

- (void)loadDefaultInfo {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.backgroundColor = [UIColor colorWithHexString:WeakBackgroundColor];// 默认背景色
}

- (void)xm_reloadData {
    self.backgroundView = nil;
    [self reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger numSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger index = 0; index < numSections; index++) {
            if ([self numberOfItemsInSection:index]) {
                havingData = YES;
                break;
            }
        }
        if (havingData) {
            self.backgroundView = nil;
        } else {
            [self updateNoneDataView];
        }
    });
}

- (void)setNoneView:(UIView *)view {
    _noneView = view;
    self.backgroundView = view;
}

#pragma mark - private
- (void)updateNoneDataView {
    if (self.noneView) {
        self.backgroundView = self.noneView;
        return;
    }
    switch (self.noneType) {
        case XMNoneDataTypeUnknown:
            self.backgroundView = [self noneDataView];
            break;
        case XMNoneDataTypeNoneNetwork:
            self.backgroundView = [self noneNetworkView];
            break;
        case XMNoneDataTypeNoneData:
            self.backgroundView = [self noneDataView];
            break;
        case XMNoneDataTypeNoneAuthorization:
            self.backgroundView = [self noneAuthorizationView];
            break;
        case XMNoneDataTypeOther:
            self.backgroundView = [self otherView];
            break;
        default:
            self.backgroundView = [self noneDataView];
            break;
    }
}

#warning 自己实现下面自定义
- (UIView *)noneNetworkView {
    if (!_noneNetworkView) {
        _noneNetworkView = [UIView new];
    }
    return _noneNetworkView;
}

- (UIView *)noneDataView {
    if (!_noneDataView) {
        _noneDataView = [UIView new];
    }
    return _noneDataView;
}

- (UIView *)noneAuthorizationView {
    if (!_noneAuthorizationView) {
        _noneAuthorizationView = [UIView new];
    }
    return _noneAuthorizationView;
}

- (UIView *)otherView {
    if (!_otherView) {
        _otherView = [UIView new];
    }
    return _otherView;
}

@end
