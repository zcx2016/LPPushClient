//
//  LPPChangeNickNameView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPChangeNickNameView.h"

@implementation LPPChangeNickNameView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    
    self.popView.layer.cornerRadius = 5;
    self.popView.layer.masksToBounds = YES;
    
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    
    self.doneBtn.layer.cornerRadius = 5;
    self.doneBtn.layer.masksToBounds = YES;
    
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelBtnClick:(UIButton *)btn{
    NSLog(@"取消修改昵称");
    //消除弹窗
    [self dissMissView];
}

- (void)doneBtnClick:(UIButton *)btn{
    NSLog(@"确认修改昵称");
    //保存昵称，再消除弹窗
    [self dissMissView];
}

- (void)dissMissView{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
