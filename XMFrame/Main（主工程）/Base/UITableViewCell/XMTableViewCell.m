//
//  XMTableViewCell.m
//  XMFrame
//
//  Created by Mifit on 2019/2/20.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMTableViewCell.h"

@implementation XMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cell_height {
    return 50.0f;
}
@end
