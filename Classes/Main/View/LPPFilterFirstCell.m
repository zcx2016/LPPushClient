//
//  LPPFilterFirstCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPFilterFirstCell.h"

@implementation LPPFilterFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)upBtnClick:(UIButton *)btn{
    [btn setImage:[UIImage imageNamed:@"upArrow_highlight"] forState:UIControlStateNormal];
    [self.downBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(pickUpOrDown:)]) {
        [self.delegate pickUpOrDown:0];
    }
}

- (void)downBtnClick:(UIButton *)btn{
    [btn setImage:[UIImage imageNamed:@"downArrow_highlight"] forState:UIControlStateNormal];
    [self.upBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(pickUpOrDown:)]) {
        [self.delegate pickUpOrDown:1];
    }
}
@end
