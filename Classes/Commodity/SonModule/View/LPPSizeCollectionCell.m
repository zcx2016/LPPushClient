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

    self.sizeBtn.layer.cornerRadius = 5;
    self.sizeBtn.layer.masksToBounds = YES;
}

- (void)setModel:(LPPSizeListModel *)model{
    _model = model;
    
    if (model.value.length != 0) {
            [self.sizeBtn setTitle:model.value forState:UIControlStateNormal];
    }
}

@end
