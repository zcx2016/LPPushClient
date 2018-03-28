//
//  LPPUserCenterCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUserCenterCell.h"
#import "LPPReturnAfterSaleVC.h"
#import "LPPMyOrderVC.h"

#import "LPPWaitPayOrderVC.h"
#import "LPPWaitPostOrderVC.h"
#import "LPPWaitReceiveOrderVC.h"

@implementation LPPUserCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.waitPayBtn addTarget:self action:@selector(waitPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitDelieverBtn addTarget:self action:@selector(waitDelieverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitReceiveBtn addTarget:self action:@selector(waitReceiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitAfterSaleBtn addTarget:self action:@selector(waitAfterSaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//待付款
- (void)waitPayBtnClick:(UIButton *)btn{
    LPPMyOrderVC *vc = [LPPMyOrderVC new];
    vc.btnName = @"待付款";
//    vc.topView.tag = 1;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//待发货
- (void)waitDelieverBtnClick:(UIButton *)btn{
    LPPMyOrderVC *vc = [LPPMyOrderVC new];
    vc.btnName = @"待发货";
//    vc.topView.tag = 2;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//待收货
- (void)waitReceiveBtnClick:(UIButton *)btn{
    LPPMyOrderVC *vc = [LPPMyOrderVC new];
    vc.btnName = @"待收货";
//    vc.topView.tag = 3;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//售后
- (void)waitAfterSaleBtnClick:(UIButton *)btn{
    LPPReturnAfterSaleVC *returnAfterSaleVc = [LPPReturnAfterSaleVC new];
    [[self viewController].navigationController pushViewController:returnAfterSaleVc animated:YES];
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
