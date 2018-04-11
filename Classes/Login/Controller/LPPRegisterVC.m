//
//  LPPRegisterVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRegisterVC.h"

@interface LPPRegisterVC ()

@property (nonatomic, copy) NSString  *verifyCode;

@end

@implementation LPPRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"注册";
    
    //设置背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"register_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn addTarget:self action:@selector(registerEvents:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //发送验证码
    [self.sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCodeEvents) forControlEvents:UIControlEventTouchUpInside];
    
    self.inviteCodeTextField.returnKeyType = UIReturnKeyDone;
    self.inviteCodeTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.inviteCodeTextField resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)sendVerifyCodeEvents{

    if ([self isAllowSendVerifyCode]) {
        NSDictionary *dict = @{@"mobile" : self.phoneNumTextField.text , @"type" : @"1"};
        [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/send_register_code.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"-手机发送注册验证码---%@",responseObject);
            self.verifyCode = responseObject[@"code"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---error -- %@",error);
        }];
    }
}

- (void)backBtnClick:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerEvents:(UIButton *)btn{
    NSLog(@"self.verifyCode----%@",self.verifyCode);
    if ([self isAllowRegister]) {
        NSString *password = self.pwdNumTextField.text;
        NSString *telephone = self.phoneNumTextField.text;
        NSString *verify_code = self.verifyCodeTextField.text;
        NSString *invitationCode = @"C11C4E4C";
        NSDictionary *dict = @{@"password": password,@"mobile" :telephone , @"telephone" : telephone,@"verify_code" : verify_code, @"invitationCode" : invitationCode ,@"roleJudge": @"PUSHING" ,@"type" : @"mobile"};
        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/register_finish.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"code"] isEqualToNumber:@100]) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"注册失败！"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error----%@",error);
        }];
    }
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

- (BOOL)isAllowRegister{
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
    if ([self.verifyCodeTextField.text isEqualToString:@"" ] || self.verifyCodeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.pwdNumTextField.text isEqualToString:@"" ] || self.pwdNumTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.surePwdTextField.text isEqualToString:@"" ] || self.surePwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if ([self.inviteCodeTextField.text isEqualToString:@""] || self.inviteCodeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"邀请码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if (self.pwdNumTextField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码位数不能少于6位！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if (![self.pwdNumTextField.text isEqualToString:self.surePwdTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一样！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}
@end
