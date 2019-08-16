//
//  XMCollapsibleView.h
//  Test
//
//  Created by Mifit on 2018/12/7.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHeaderView;

@protocol XMCollapsibleViewDelegate <NSObject>
@required
/// 分组个数
- (NSInteger)numberOfSection;

/// 第几组有几个
- (NSInteger)numberOfRowAtSection:(NSInteger)section;

/// 内容
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/// 分组抬头view
- (XMHeaderView *)viewForHeaderInSection:(NSInteger)section;
@optional
/// 点击section
- (void)didSelectedAtSection:(NSInteger)section;

/// 点击某个cell
- (void)didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;

/// cell高度
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath;

/// section高度
- (CGFloat)heightForSectionHeaderAtSection:(NSInteger)section;
@end

@interface XMCollapsibleView : UIView

@property (nonatomic, weak) id<XMCollapsibleViewDelegate> delegate;

/// 注册重用cell的类, UITableviewCell的子类
- (void)registerReuseCellWithClass:(Class)cls withIdentifier:(NSString *)identifier;
- (void)registerReuseCellWithNib:(UINib *)nib withIdentifier:(NSString *)identifier;

/// 注册重用section的类, XMHeaderView的子类
- (void)registerReuseHeaderWithClass:(Class)cls withIdentifier:(NSString *)identifier;
- (void)registerReuseHeaderWithNib:(UINib *)nib withIdentifier:(NSString *)identifier;

/// 获取重用视图
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (XMHeaderView *)dequeueReusableHeaderWithIdentifier:(NSString *)identifier;

/// 刷新
- (void)reloadData;
- (void)reloadAtSection:(NSInteger)section;
- (void)reloadRow:(NSInteger)row atSection:(NSInteger)section;

/// 判断是否折叠起来
- (BOOL)isCollapedAtSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
