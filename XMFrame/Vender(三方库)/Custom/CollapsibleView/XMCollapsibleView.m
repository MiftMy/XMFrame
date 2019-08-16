//
//  XMCollapsibleView.m
//  Test
//
//  Created by Mifit on 2018/12/7.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMCollapsibleView.h"
#import "XMHeaderView.h"

typedef NS_ENUM(NSInteger, MRSectionState) {
    MRSectionStateNormal = 0,   // 正常
    MRSectionStateCollapse,     // 折叠
};

@interface XMCollapsibleView()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionState;

@end

@implementation XMCollapsibleView

#pragma mark - init
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_tableView) {
        UITableView *tbView = [UITableView new];
        [self addSubview:tbView];
        tbView.frame = self.bounds;
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.tableFooterView = [UIView new];
        self.tableView = tbView;
        
        if (@available(iOS 11.0, *)) {
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
        }
    }
}

- (void)layoutSubviews {
    _tableView.frame = self.bounds;
}

#pragma mark - lazy load
- (NSMutableArray *)sectionState {
    if (!_sectionState) {
        _sectionState = [NSMutableArray array];
    }
    return _sectionState;
}
#pragma mark - public

- (void)registerReuseCellWithClass:(Class)class withIdentifier:(NSString *)identifier {
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
}

- (void)registerReuseCellWithNib:(UINib *)nib withIdentifier:(NSString *)identifier {
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)registerReuseHeaderWithClass:(Class)cls withIdentifier:(NSString *)identifier {
    [self.tableView registerClass:cls forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)registerReuseHeaderWithNib:(UINib *)nib withIdentifier:(NSString *)identifier {
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
}

///// 下面三行解决闪屏，自动滚动到顶部问题。
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 0.0f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return 0.0f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    return 0.0f;
//}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [self.tableView dequeueReusableCellWithIdentifier:identifier];
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderWithIdentifier:(NSString *)identifier {
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)reloadAtSection:(NSInteger)section {
//    [self.tableView reloadData];
    [UIView performWithoutAnimation:^{
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)reloadRow:(NSInteger)row atSection:(NSInteger)section {
    MRSectionState state = [self.sectionState[section] integerValue];
    if (MRSectionStateCollapse != state) {
        [self.tableView reloadData];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (BOOL)isCollapedAtSection:(NSInteger)section {
    MRSectionState state = [self.sectionState[section]integerValue];
    return (state == MRSectionStateCollapse);
}
#pragma mark - private
- (void)updateSectionCount:(NSInteger)count {
    if (count != self.sectionState.count) {
        NSInteger addCount = count - self.sectionState.count;
        if (addCount > 0) { // 添加几个
            while (addCount--) {
                [self.sectionState addObject:@(MRSectionStateCollapse)];
            }
        } else {
            addCount = abs(addCount);
            // 剪掉后面几个
            [self.sectionState removeObjectsInRange:NSMakeRange(count, addCount)];
        }
    }
}
#pragma mark data sources
#pragma mark - collectionView delegate
//  完全自定义占位图
- (UIView *)xy_noDataView{
    return  [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numSection = [self.delegate numberOfSection];
    [self updateSectionCount:numSection];
    return numSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MRSectionState state = [self.sectionState[section] integerValue];
    if (MRSectionStateCollapse == state) {
        return 0;
    }
    return [self.delegate numberOfRowAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.delegate cellForRowAtIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMHeaderView *view = [self.delegate viewForHeaderInSection:section];
    __weak typeof(self) weakSelf = self;
    view.backgroupTapBlck = ^() {
        __strong typeof(self) swSelf = weakSelf;
        MRSectionState state = [swSelf.sectionState[section] integerValue];
        if (MRSectionStateNormal == state) {
            state = MRSectionStateCollapse;
        } else {
            state = MRSectionStateNormal;
        }
        [swSelf.sectionState replaceObjectAtIndex:section withObject:@(state)];
        [swSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        if (swSelf.delegate && [swSelf.delegate respondsToSelector:@selector(didSelectedAtSection:)]) {
            [swSelf.delegate didSelectedAtSection:section];
        }
    };
    return view;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForCellAtIndexPath:)]) {
        return [self.delegate heightForCellAtIndexPath:indexPath];
    } else {
        return 60.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForSectionHeaderAtSection:)]) {
        return [self.delegate heightForSectionHeaderAtSection:section];
    }
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedRowAtIndexPath:)]) {
        [self.delegate didSelectedRowAtIndexPath:indexPath];
    }
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}


//- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    // delete action
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"del" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
//    }];
//
//    // 创建action
//    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"read" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
//    }];
//
//    UITableViewRowAction *searchAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"search" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
//    }];
//
//    return @[deleteAction, readAction, searchAction];
//}

@end
