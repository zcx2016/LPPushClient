//
//  LPPPayMethodFooterView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPPayMethodFooterView.h"

@implementation LPPPayMethodFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //微信支付
    self.wechatPayView.userInteractionEnabled = YES;
    [self.wechatPayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weChatPay:)]];
    
    //支付宝支付
    self.aliPayView.userInteractionEnabled = YES;
    [self.aliPayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aliPay:)]];
}

- (void)weChatPay:(UITapGestureRecognizer *)recognize{
    [self.wechatPayBtn setImage:[UIImage imageNamed:@"pay_yes"] forState:UIControlStateNormal];
    [self.aliPayBtn setImage:[UIImage imageNamed:@"pay_no"] forState:UIControlStateNormal];
}

- (void)aliPay:(UITapGestureRecognizer *)recognize{
    [self.aliPayBtn setImage:[UIImage imageNamed:@"pay_yes"] forState:UIControlStateNormal];
    [self.wechatPayBtn setImage:[UIImage imageNamed:@"pay_no"] forState:UIControlStateNormal];
}
@end
