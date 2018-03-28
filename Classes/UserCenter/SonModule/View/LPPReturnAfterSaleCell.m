//
//  LPPReturnAfterSaleCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPReturnAfterSaleCell.h"
#import "LPPApplyReturnAfterSaleVC.h"

@implementation LPPReturnAfterSaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.masksToBounds = YES;

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.masksToBounds = YES;
    
    self.applyAfterSaleBtn.layer.cornerRadius = 3;
    self.applyAfterSaleBtn.layer.masksToBounds = YES;
    
    [self.applyAfterSaleBtn addTarget:self action:@selector(applyAfterSaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)applyAfterSaleBtnClick:(UIButton *)btn{
    LPPApplyReturnAfterSaleVC *applyReturnAfterSaleVc = [LPPApplyReturnAfterSaleVC new];
    [[self viewController].navigationController pushViewController:applyReturnAfterSaleVc animated:YES];
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
