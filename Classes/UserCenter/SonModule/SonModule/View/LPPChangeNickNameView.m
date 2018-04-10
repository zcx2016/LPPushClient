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
    
    //修改键盘右下角
    self.nickNameTextField.returnKeyType = UIReturnKeyDone;
    self.nickNameTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.nickNameTextField resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)cancelBtnClick:(UIButton *)btn{
    NSLog(@"取消修改昵称");
    //消除弹窗
    [self dissMissView];
}

- (void)doneBtnClick:(UIButton *)btn{
    NSLog(@"确认修改昵称");
    
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"user_id" : user_id , @"nickName" : self.nickNameTextField.text};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/index_update_nickAame.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nickNameChanged" object:nil];
        [self dissMissView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
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
