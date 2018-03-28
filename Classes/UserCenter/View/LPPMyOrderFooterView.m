//
//  LPPMyOrderFooterView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderFooterView.h"

@implementation LPPMyOrderFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.masksToBounds = YES;
    
    self.cancelOrderBtn.layer.cornerRadius = 3;
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancelOrderBtn.layer.masksToBounds = YES;
    
    self.goToPayBtn.layer.cornerRadius = 3;
    self.goToPayBtn.layer.masksToBounds = YES;
}

@end
