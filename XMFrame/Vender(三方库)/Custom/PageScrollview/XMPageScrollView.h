//
//  XMPageScrollView.h
//  Test
//
//  Created by Mifit on 2018/11/21.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XMPageScrollView, XMReuseView;

@protocol XMPageScrollViewDataSource <NSObject>

@required

/**
 总item数
 
 @param pageScrollView XMPageScrollView
 @return 总个数
 */
- (NSInteger)numberOfItems:(XMPageScrollView *)pageScrollView;

/**
 将要显示时候获取view
 
 @param pageScrollView  XMPageScrollView
 @param index           索引
 @return 要显示的cell
 */
- (XMReuseView *)pageScrollview:(XMPageScrollView *)pageScrollView cellAtIndex:(NSInteger)index;

@end

@protocol XMPageScrollViewDelegate <NSObject>
@optional
/*
    是否需要加载更多数据，滚到最后一个时候
 */
- (void)needLoadMorePageData:(XMPageScrollView *)pageScrollView;

/*
    某一页将要从屏幕消失。
 */
- (void)pageScrollView:(XMPageScrollView *)pageScrollView willDisappearCellAtIndex:(NSInteger)index;

/*
    某一页完全消失在屏幕。
 */
- (void)pageScrollView:(XMPageScrollView *)pageScrollView didDisappearCellAtIndex:(NSInteger)index;

/*
    将要显示某一页。
 */
- (void)pageScrollView:(XMPageScrollView *)pageScrollView willAappearCellAtIndex:(NSInteger)index;


/*
    某一页完全显示时候回调,与屏幕相差个像素内全部显示，快速滚动时候不能保证完成与self的bounds吻合。
 */
- (void)pageScrollView:(XMPageScrollView *)pageScrollView didAppearCellAtIndex:(NSInteger)index;

@end

/*
    水平和垂直的 page scrollview
    实现MVC重用机制的Page Scrollview
    使用流程和tableview类似
 */
@interface XMPageScrollView : UIScrollView
@property (nonatomic, weak) id <XMPageScrollViewDataSource> dataSourceDelegate;
@property (nonatomic, weak) id <XMPageScrollViewDelegate> showDelegate;// scrollview本身有一个delegate了，只能改名

/// item个数
@property (nonatomic, assign, readonly) NSInteger itemCount;

/// 滚动方向。是否水平的？
@property (nonatomic, assign) BOOL isHorizion;

/// 是否处理scrollview滚动事件，比如缩放时候，不应该处理。处理会导致代理回调，加载/删除page。缩放完毕后恢复。
@property (nonatomic, assign) BOOL isDealScroll;

/// 当前page索引 从0开始。设置值时候会设置contentoffset，引起scrollview滚动，从而达到加载新视图目的。
@property (nonatomic, assign) NSInteger currentIndex;


/// 重新加载数据，不会滚回顶部，
- (void)reloadData;

/**
    注册重用的类的标识
 */
- (void)registerClass:(Class)class forCellReuseIdentifier:(NSString *)identifier;

/**
 从缓冲区获取复用view
 @param index    索引
 @return View
 */
- (XMReuseView *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
