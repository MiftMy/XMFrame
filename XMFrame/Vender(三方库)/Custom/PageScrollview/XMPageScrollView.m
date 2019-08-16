//
//  XMPageScrollView.m
//  Test
//
//  Created by Mifit on 2018/11/21.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMPageScrollView.h"

#import "XMReuseView.h"

@interface XMPageScrollView()
<UIScrollViewDelegate>
{
    CGFloat _lastValue;
}

@property (nonatomic, strong) NSMutableDictionary *identifiers;

/**
 page的个数
 */
@property (nonatomic, assign) NSInteger itemCount;

/**
 *  保存可见的视图
 */
@property (nonatomic, strong) NSMutableSet *visibleViews;

/**
 *  保存未显示可重用的视图
 */
@property (nonatomic, strong) NSMutableSet *reusedViews;

@end

@implementation XMPageScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                     capacity:(NSInteger)capacity {
    self = [super initWithFrame:frame];
    if (self) {
        _itemCount = capacity;
        [self initData];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self reloadData];
}

/// 需要优化，每次滚动时候都调用。调用该方法更新子view的frame和scrollview的contentSize和offset。super view frame 改变时候更新子view的
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateSubViews];
}

//当frame改变时候,更新contentSize和contentOffset
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self resetScrollview];
}

- (void)initData {
    _itemCount = 0;
    _currentIndex = 0;
    _lastValue = 0;
    _isDealScroll = YES;
    for (XMReuseView *view in self.visibleViews) {
        [_reusedViews addObject:view];
    }
    [_visibleViews removeAllObjects];
    self.userInteractionEnabled = YES;
    self.contentInset = UIEdgeInsetsZero;
    self.bounces = YES;
    self.delegate = self;
//    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

#pragma mark - UIScrollViewDelegate
// 即将开始滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.isDealScroll) {
        return;
    }
    if (self.isHorizion) {
        _lastValue = scrollView.bounds.origin.x;
    } else {
        _lastValue = scrollView.bounds.origin.y;
    }
}

/// 手势离开
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isDealScroll) {
        //回调到外面说明需要加载更多数据
        if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(needLoadMorePageData:)]) {
            NSInteger pageIndex = [self countPageIndex];
            if (pageIndex >= self.itemCount) { // 是否边界
                BOOL isBig = NO; // 达到边界后往右or下移动了
                if (self.isHorizion) {
                    isBig = (_lastValue < scrollView.bounds.origin.x);
                } else {
                    isBig = _lastValue < scrollView.bounds.origin.y;
                }
                if (isBig) {
                    [self.showDelegate needLoadMorePageData:self];
                }
            }
        }
    }
}

/// 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isDealScroll) {
        [self showPages];
    }
}

/// 滚动完成，连续滚动页面时候中间不会调用，只有停止的时候才调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isDealScroll) {
        NSInteger pageIndx = [self countPageIndex];
        if (_currentIndex != pageIndx) {
            _currentIndex = pageIndx;
            if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(pageScrollView:didAppearCellAtIndex:)]) {
                [self.showDelegate pageScrollView:self didAppearCellAtIndex:pageIndx];
            }
        }
    }
}

#pragma mark 处理滚动中的展示
- (void)showPages {
    // 获取当前处于显示范围的 索引
    CGRect visibleBounds = self.bounds;
    NSInteger firstIndex = 0, lastIndex = 0, pageSpace = 0, offsetValue = 0;
    
    if (self.isHorizion) {
        offsetValue = visibleBounds.origin.x;
        CGFloat minX  = CGRectGetMinX(visibleBounds);
        CGFloat maxX  = CGRectGetMaxX(visibleBounds)-1;
        CGFloat width = CGRectGetWidth(visibleBounds);
        firstIndex = (NSInteger)floorf(minX / width);
        lastIndex  = (NSInteger)floorf(maxX / width);
        pageSpace = width;
    } else {
        offsetValue = visibleBounds.origin.y;
        CGFloat minY  = CGRectGetMinY(visibleBounds);
        CGFloat maxY  = CGRectGetMaxY(visibleBounds)-1;
        CGFloat height = CGRectGetHeight(visibleBounds);
        firstIndex = (NSInteger)floorf(minY / height);
        lastIndex  = (NSInteger)floorf(maxY / height);
        pageSpace = height;
    }
    
    // 计算当前显示的索引。条件入下所示
    NSInteger l = offsetValue % pageSpace;
    if (abs(l - pageSpace) <= pageSpace/3) { // 显示全的条件，显示2/3当显示全部。快速滑动可能会错过。需要在滚动完成里面处理。
        NSInteger nearIndex = round(offsetValue / pageSpace);
        if (_currentIndex != nearIndex) {
            _currentIndex = nearIndex;
            if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(pageScrollView:didAppearCellAtIndex:)]) {
                [self.showDelegate pageScrollView:self didAppearCellAtIndex:nearIndex];
            }
        }
    }
    
    // 处理越界
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    if (lastIndex >= _itemCount) {
        lastIndex = _itemCount - 1;
    }
    
    // 回收不在显示 的
    NSInteger viewIndex = 0;
    for (UIView *pageview in self.visibleViews) {
        viewIndex = pageview.tag;
        // 不在显示范围内
        if ( viewIndex < firstIndex || viewIndex > lastIndex) {
            [self.reusedViews addObject:pageview];
            //回调出去Page消失
            if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(pageScrollView:willDisappearCellAtIndex:)]) {
                [self.showDelegate pageScrollView:self willDisappearCellAtIndex:viewIndex];
            }
            [pageview removeFromSuperview];
            if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(pageScrollView:didDisappearCellAtIndex:)]) {
                [self.showDelegate pageScrollView:self didDisappearCellAtIndex:viewIndex];
            }
        }
    }
    [self.visibleViews minusSet:self.reusedViews];
    
    // 是否需要显示新的视图
    for (NSInteger index = firstIndex; index <= lastIndex; index ++) {
        BOOL isShow = NO; //当前索引index的view是否显示
        for (UIView * pageView in self.visibleViews) {
            if (pageView.tag == index) {
                isShow = YES;
                break;
            }
        }
        if (!isShow ) {
            //回调出去page显示
            if (self.showDelegate && [self.showDelegate respondsToSelector:@selector(pageScrollView:willAappearCellAtIndex:)]) {
                [self.showDelegate pageScrollView:self willAappearCellAtIndex:index];
            }
            /// 添加索引为index的view
            [self showCellAtIndex:index];
        }
    }
}

/// 显示view
- (void)showCellAtIndex:(NSInteger)index{
    UIView *pageView = nil;
    if (self.dataSourceDelegate && [self.dataSourceDelegate respondsToSelector:@selector(pageScrollview:cellAtIndex:)]) {
        pageView = [self.dataSourceDelegate pageScrollview:self cellAtIndex:index];
    } else {
        return;
    }
    if (!pageView) {
        return;
    }
    //以上为获取view
    pageView.tag = index;
    [self.visibleViews addObject:pageView];
    [self addSubview:pageView];
}

#pragma mark - lazy
/// 可视view set
- (NSMutableSet *)visibleViews {
    if (!_visibleViews) {
        _visibleViews = [[NSMutableSet  alloc] init];
    }
    return _visibleViews;
}

/// 复用view set
- (NSMutableSet *)reusedViews {
    if (!_reusedViews) {
        _reusedViews = [[NSMutableSet  alloc] init];
    }
    return _reusedViews;
}

- (NSMutableDictionary *)identifiers {
    if (!_identifiers) {
        _identifiers = [NSMutableDictionary dictionary];
    }
    return _identifiers;
}

#pragma mark - private
- (XMReuseView *)reuseCellFromCacheWithIdentifier:(NSString *)identifier {
    XMReuseView *cell = nil;
    for (XMReuseView *view in self.reusedViews) {
        if (view.identifier == identifier) {
            cell = view;
            break;
        }
    }
    return cell;
}

- (NSInteger)countPageIndex {
    if (self.isHorizion) {
        CGFloat pageWidth = self.frame.size.width;
        NSInteger pageIndex = round(self.contentOffset.x / pageWidth);// 使用round是因为小数点问题。
        return pageIndex;
    }
    CGFloat pageHeight = self.frame.size.height;
    NSInteger pageIndex = round(self.contentOffset.y / pageHeight);
    return pageIndex;
}

- (CGPoint)offsetForScrollviewAtIndex:(NSInteger)index {
    return [self pointAtIndex:index];
}

- (CGSize)sizeForScrollview {
    CGSize size = self.bounds.size;
    if (self.isHorizion) {
        return CGSizeMake(size.width*self.itemCount, size.height);
    }
    return CGSizeMake(size.width, self.itemCount*size.height);
}

// item的point
- (CGPoint)pointAtIndex:(NSInteger)index {
    CGSize size = self.bounds.size;
    if (self.isHorizion) {
        return CGPointMake(index*size.width, 0);
    }
    return CGPointMake(0, index*size.height);
}

// item的rect
- (CGRect)rectForCellAtIndex:(NSInteger)index {
    CGSize size = self.bounds.size;
    CGRect rect;
    if (self.isHorizion) {
        rect = CGRectMake(index*size.width, 0, size.width, size.height);
    } else {
        rect = CGRectMake(0, index*size.height, size.width, size.height);
    }
    return rect;
}

// 子view使用frame和layout都可以更新
- (void)updateSubViews {
    for (UIView *view in self.visibleViews) {
        CGRect rect = view.frame;
        rect.size = self.bounds.size;
        rect.origin = [self pointAtIndex:view.tag];
        view.frame = rect;
        [view setNeedsDisplay];
        [view setNeedsLayout];
    }
}

- (void)resetScrollview {
    self.contentSize = [self sizeForScrollview];;
    self.contentOffset = [self offsetForScrollviewAtIndex:_currentIndex];
}
#pragma mark - 对外接口
- (void)registerClass:(Class)class forCellReuseIdentifier:(NSString *)identifier {
    self.identifiers[identifier] = class;
}

/// 重新加载
- (void) reloadData {
    //重置scrollview 的contentSize
    if (self.dataSourceDelegate) {
        NSInteger count = [self.dataSourceDelegate numberOfItems:self];
        self.itemCount = count;
        if (self.itemCount > 0) {// reset contentSize
            self.contentSize = [self sizeForScrollview];
            [self setContentOffset:[self pointAtIndex:_currentIndex]];
            [self showPages];
        } else {
            //是否需要重置？
        }
    }
}

/// 重用的view
- (XMReuseView *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    NSParameterAssert(identifier);
    XMReuseView *pageView = [self reuseCellFromCacheWithIdentifier:identifier];
    if (pageView) {
        [self.reusedViews removeObject:pageView];
    } else {
        Class XMReuseView = self.identifiers[identifier];
        pageView = [[XMReuseView alloc]initWithReuseIdentifier:identifier];
    }
    CGRect rect =  [self rectForCellAtIndex:index];
    pageView.frame = rect;
    return pageView;
}

- (void)setCurrentIndex:(NSInteger)index {
    if (_currentIndex != index) {
        _currentIndex = index;
        [self setContentOffset:[self offsetForScrollviewAtIndex:_currentIndex]];
    }
}
@end
