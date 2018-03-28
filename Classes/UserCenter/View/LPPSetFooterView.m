//
//  LPPSetFooterView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPSetFooterView.h"

@implementation LPPSetFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.quitLoginBtn.layer.cornerRadius = 10;
    self.quitLoginBtn.layer.masksToBounds = YES;
}

@end
