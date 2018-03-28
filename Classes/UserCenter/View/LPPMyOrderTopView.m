//
//  LPPMyOrderTopView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderTopView.h"

@implementation LPPMyOrderTopView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 64, kScreenWidth, 100);
    self.uselessLineView.hidden = YES;
    
    //上面的view
    [self.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitPayBtn addTarget:self action:@selector(waitPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitShipBtn addTarget:self action:@selector(waitShipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.waitReceiveBtn addTarget:self action:@selector(waitReceiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //下面的view
    self.downOutView.layer.cornerRadius = 5;
    self.downOutView.layer.borderWidth = 1;
    self.downOutView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.downOutView.layer.masksToBounds = YES;
    
    self.searchTextField.returnKeyType = UIReturnKeyDone;
    self.searchTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.searchTextField resignFirstResponder];
}

//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.tag == 1) {
        NSLog(@"tag---%ld",(long)self.tag);
    }else if (self.tag == 2){
        NSLog(@"tag---%ld",(long)self.tag);
    }else{
        NSLog(@"tag---%ld",(long)self.tag);
    }
}

//父子控制器
//由于此处是每个btn在单独的view里面，（4个btn不是在一个view里）所以sender.tag 都是0，因此只能在调用代理的地方 根据按钮名称 来判断 index了。
- (IBAction)fourBtnEachClick:(UIButton *)sender {
    if ([self.stateSelectedDelegate respondsToSelector:@selector(fourBtnClick:)]) {
        [self.stateSelectedDelegate fourBtnClick:sender];
    }
}

#pragma mark - 4个按钮点击事件
- (void)allBtnClick:(UIButton *)btn{
    [self.allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.allLineView.hidden = NO;
    
    [self.waitPayBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitPayLineView.hidden = YES;
    [self.waitShipBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitShipLineView.hidden = YES;
    [self.waitReceiveBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitReceiveLineView.hidden = YES;
}

- (void)waitPayBtnClick:(UIButton *)btn{
    [self.waitPayBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    self.waitPayLineView.hidden = NO;
    
    [self.allBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.allLineView.hidden = YES;
    [self.waitShipBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitShipLineView.hidden = YES;
    [self.waitReceiveBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitReceiveLineView.hidden = YES;
}

- (void)waitShipBtnClick:(UIButton *)btn{
    [self.waitShipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.waitShipLineView.hidden = NO;

    [self.waitPayBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitPayLineView.hidden = YES;
    [self.allBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.allLineView.hidden = YES;
    [self.waitReceiveBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitReceiveLineView.hidden = YES;
}

- (void)waitReceiveBtnClick:(UIButton *)btn{
    [self.waitReceiveBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    self.waitReceiveLineView.hidden = NO;
    
    [self.waitPayBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitPayLineView.hidden = YES;
    [self.waitShipBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.waitShipLineView.hidden = YES;
    [self.allBtn setTitleColor:ZCXColor(242, 173, 163) forState:UIControlStateNormal];
    self.allLineView.hidden = YES;
}

@end
