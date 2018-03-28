//
//  LPPLogisticsDetailTopView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPLogisticsDetailTopView.h"

@implementation LPPLogisticsDetailTopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, 224);
    
    self.outView.layer.cornerRadius = 3;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.masksToBounds = YES;
    
    self.commodityImgView.layer.cornerRadius = 3;
    self.commodityImgView.layer.masksToBounds = YES;
}

@end
