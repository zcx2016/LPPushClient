//
//  LPPUserCenterFooterView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUserCenterFooterView.h"
#import "LPPMyAccountVC.h"

@implementation LPPUserCenterFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.myDistributionBtn.layer.cornerRadius = 5;
    self.myDistributionBtn.layer.masksToBounds = YES;
    [self.myDistributionBtn addTarget:self action:@selector(myDistributionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.myAccountBtn.layer.cornerRadius = 5;
    self.myAccountBtn.layer.masksToBounds = YES;
    [self.myAccountBtn addTarget:self action:@selector(myAccountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)myDistributionBtnClick:(UIButton *)btn{
    NSLog(@"111");
}

- (void)myAccountBtnClick:(UIButton *)btn{
    LPPMyAccountVC *myAccountVc = [LPPMyAccountVC new];
    [[self viewController].navigationController pushViewController:myAccountVc animated:YES];
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
