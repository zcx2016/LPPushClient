//
//  LPPApplyServerTypeCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPApplyServerTypeCell.h"

@implementation LPPApplyServerTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.exchangeGoodsBtn.layer.cornerRadius = 3;
    self.exchangeGoodsBtn.layer.masksToBounds = YES;
    
    self.refundBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.refundBtn.layer.borderWidth = 1;
    self.refundBtn.layer.cornerRadius = 3;
    self.refundBtn.layer.masksToBounds = YES;
}

@end
