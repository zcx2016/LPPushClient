//
//  LPPGoodsTitleCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/11.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPGoodsTitleCell.h"

@implementation LPPGoodsTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.indicatorView.hidden = YES;
}

- (void)setModel:(LPPGoodsTitleModel *)model{
    _model = model;
    
    self.titleLabel.text = model.name;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.indicatorView.hidden = selected? NO : YES;
    self.titleLabel.textColor = selected ? [UIColor whiteColor] : ZCXColor(238, 147, 134);
}

@end
