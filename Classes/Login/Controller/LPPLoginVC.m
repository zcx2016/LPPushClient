//
//  LPPLoginVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPLoginVC.h"
#import "LPPRegisterVC.h"
#import "LPPFindPwdVC.h"
#import "LPPUseProtocolVC.h"

@interface LPPLoginVC ()

@end

@implementation LPPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"登录";
    
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"login_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    //注册
    [self.registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //协议文字 点击事件
    self.protocolLabel.userInteractionEnabled = YES;
    [self.protocolLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelClick:)]];
    
    //已同意按钮
    [self.agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //手机短信登录 按钮
    [self.phoneMesLoginBtn addTarget:self action:@selector(phoneMesLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//忘记密码
- (void)phoneMesLoginBtnClick:(UIButton *)btn{
    LPPFindPwdVC *findPwdVc = [LPPFindPwdVC new];
    [self presentViewController:findPwdVc animated:YES completion:nil];
}

- (BOOL)isAllowLogin{
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
    if ([self.pwdNumTextField.text isEqualToString:@""] || self.pwdNumTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}

- (void)loginBtnClick:(UIButton *)btn{
    if ([self isAllowLogin]) {
        NSDictionary *dict = @{@"telephone" : @"13512345679" , @"password" : @"000000" , @"roleJudge" : @"PUSHING"};
        [ZcxUserDefauts setObject:@"13512345679" forKey:@"telephone"];
        [ZcxUserDefauts setObject:@"000000" forKey:@"password"];
        [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/jopen_shop_user_login.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"登录res----%@",responseObject);
            [ZcxUserDefauts setObject:responseObject[@"token"] forKey:@"token"];
            [ZcxUserDefauts setObject:responseObject[@"user_id"] forKey:@"user_id"];
            [ZcxUserDefauts setObject:responseObject[@"verify"] forKey:@"verify"];
            [ZcxUserDefauts synchronize];
            //登录按钮暂时做退出使用
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"登录error----%@",error);
        }];
    }
}

//点击协议
- (void)protocolLabelClick:(UITapGestureRecognizer *)recognize{
    
    LPPUseProtocolVC *protocolVc = [LPPUseProtocolVC new];
    [self presentViewController:protocolVc animated:YES completion:nil];
}


- (void)registerBtnClick:(UIButton *)btn{
    LPPRegisterVC *registerVc = [LPPRegisterVC new];
    [self presentViewController:registerVc animated:YES completion:nil];
//    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)agreeBtnClick:(UIButton *)btn{
    if (!btn.selected) {
        [btn setImage:[UIImage imageNamed:@"login_choose"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
    }else{
        [btn setImage:[UIImage imageNamed:@"login_unChoose"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
    }
}


@end
