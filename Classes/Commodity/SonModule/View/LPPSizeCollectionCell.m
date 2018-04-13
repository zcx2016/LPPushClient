//
//  LPPSizeCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/10.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPSizeCollectionCell.h"

@implementation LPPSizeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (void)setModel:(LPPSizeListModel *)model{
    _model = model;
    
    self.sizeLabel.text = model.value;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];

    self.backgroundColor = selected ? [UIColor colorWithPatternImage:[UIImage imageNamed:@"colorBtn"]] : [UIColor lightGrayColor];
}

@end
