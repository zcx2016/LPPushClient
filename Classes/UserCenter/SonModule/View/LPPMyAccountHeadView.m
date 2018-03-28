//
//  LPPMyAccountHeadView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyAccountHeadView.h"
#import "LPPWithDrawVC.h"

@implementation LPPMyAccountHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.balanceView.layer.cornerRadius = 5;
    self.balanceView.layer.masksToBounds = YES;
    
    self.moneyView.layer.cornerRadius = 5;
    self.moneyView.layer.masksToBounds = YES;
    
    //头像变圆形
    self.headImgView.layer.cornerRadius = 30;
    self.headImgView.layer.masksToBounds = YES;
    
    //提现
    [self.withDrawBtn addTarget:self action:@selector(withDrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)withDrawBtnClick:(UIButton *)btn{
    LPPWithDrawVC *withDrawVc = [LPPWithDrawVC new];
    [[self viewController].navigationController pushViewController:withDrawVc animated:YES];
}

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
