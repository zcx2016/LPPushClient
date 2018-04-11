//
//  LPPFindPwdVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPFindPwdVC.h"

@interface LPPFindPwdVC ()

@end

@implementation LPPFindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"找回密码";
    
    //设置背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"findPwd_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    //确认找回
    self.sureFindBackBtn.layer.cornerRadius = 5;
    self.sureFindBackBtn.layer.masksToBounds = YES;
    [self.sureFindBackBtn addTarget:self action:@selector(sureFindBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //返回
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //发送验证码
    [self.sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCodeEvents) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureNewPwdTextField.returnKeyType = UIReturnKeyDone;
    self.sureNewPwdTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.sureNewPwdTextField resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)sendVerifyCodeEvents{
    if ([self isAllowSendVerifyCode]) {
        NSDictionary *dict = @{@"mobile" : self.phoneNumTextField.text , @"type" : @"3"};
        [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/send_register_code.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"-手机发送找回密码。验证码---%@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---error -- %@",error);
        }];
    }
}

//确认找回
- (void)sureFindBackBtnClick{
    if ([self isAllowFindPwd]) {
        NSString *password = self.newsPwdTextField.text;
        NSString *telephone = self.phoneNumTextField.text;
        NSString *verify_code = self.verifyCodeTextField.text;
        NSDictionary *dict = @{@"password" : password , @"roleJudge" : @"PUSHING" ,@"telephone":telephone ,@"verify_code" : verify_code};
        [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/reset_Password.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"-确认找回---%@",responseObject);
            if ([responseObject[@"result"] isEqualToNumber:@01]) {
                [SVProgressHUD showSuccessWithStatus:@"找回成功！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"找回失败！"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---error -- %@",error);
        }];
    }
}


- (void)backBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)isAllowSendVerifyCode{
    //判断手机号码格式
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if(self.phoneNumTextField.text.length !=11 || [regextestmobile evaluateWithObject:self.phoneNumTextField.text] == NO){
        [SVProgressHUD showErrorWithStatus:@"手机号码格式不对！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    //判TF是否为空
    if ([self.phoneNumTextField.text isEqualToString:@"" ] || self.phoneNumTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}

- (BOOL)isAllowFindPwd{
    //判断手机号码格式
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if(self.phoneNumTextField.text.length !=11 || [regextestmobile evaluateWithObject:self.phoneNumTextField.text] == NO){
        [SVProgressHUD showErrorWithStatus:@"手机号码格式不对！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    //判断各个TF是否为空
    if ([self.phoneNumTextField.text isEqualToString:@"" ] || self.phoneNumTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.verifyCodeTextField.text isEqualToString:@"" ] || self.verifyCodeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.newsPwdTextField.text isEqualToString:@"" ] || self.newsPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.sureNewPwdTextField.text isEqualToString:@"" ] || self.sureNewPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"确认新密码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if (self.newsPwdTextField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码位数不能少于6位！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if (![self.newsPwdTextField.text isEqualToString:self.sureNewPwdTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一样！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}
@end
