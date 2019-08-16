//
//  XMHeaderView.h
//  Camera
//
//  Created by Mifit on 2019/3/23.
//  Copyright © 2019年 Tomy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MRHeaderTapBlock)(void);

@interface XMHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) MRHeaderTapBlock backgroupTapBlck;

@end

NS_ASSUME_NONNULL_END
