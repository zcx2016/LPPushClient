//
//  LPPShopCarBottomView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPShopCarBottomView.h"

@implementation LPPShopCarBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, kScreenHeight -100, kScreenWidth, 51);
    
    [self.selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectAllBtnClick:(UIButton *)btn{
    if (!btn.selected) {  //状态 变为 全选
        [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        //发送通知，给购物车里所有cell改变状态
        //----------
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shopCarSelectAll" object:nil];
    }else{  //状态 变为 不全选
        [btn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        //发送通知，给购物车里所有cell改变状态
        //----------
         [[NSNotificationCenter defaultCenter] postNotificationName:@"shopCarDisSelectAll" object:nil];
    }
}

- (void)setModel:(LPPShopCarModel *)model{
    _model = model;
    _endMoneyLabel.text = model.cart_price;
}

@end
