//
//  UICollectionView+XMTools.m
//  XMFrame
//
//  Created by 梁小迷 on 7/7/19.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "UICollectionView+XMTools.h"

@implementation UICollectionView (XMTools)
- (void)setNoneDataView:(UIView *)view {
    self.backgroundView = view;
}

- (UIView *)noneDataView {
    return self.backgroundView;
}
@end
