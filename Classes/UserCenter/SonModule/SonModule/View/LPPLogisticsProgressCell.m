//
//  LPPLogisticsProgressCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPLogisticsProgressCell.h"

@implementation LPPLogisticsProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.midCircleView.layer.borderWidth = 1;
    self.midCircleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.midCircleView.layer.cornerRadius = 5;
    self.midCircleView.layer.masksToBounds = YES;
}

@end
