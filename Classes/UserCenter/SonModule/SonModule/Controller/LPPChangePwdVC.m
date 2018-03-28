//
//  LPPChangePwdVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPChangePwdVC.h"

@interface LPPChangePwdVC ()

@end

@implementation LPPChangePwdVC

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"修改密码";
    
    self.saveBtn.layer.cornerRadius = 10;
    self.saveBtn.layer.masksToBounds = YES;
    
    //设置uiview背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"findPwd_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//先判空
- (BOOL)isNotNil{
    if (self.oldPwdTextField.text  == nil || self.oldPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"旧密码不能为空！"];
        return NO;
    }
    if (self.newsPwdTextField.text == nil || self.newsPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空!"];
        return NO;
    }
    if (self.sureNewsPwdTextField.text == nil || self.sureNewsPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再输入一次新密码不能为空!"];
        return NO;
    }
    return YES;
}

- (void)saveBtnClick:(UIButton *)btn{
    if ([self isNotNil]) {
        NSString *originPwd = [ZcxUserDefauts objectForKey:@"password"];
        if (![originPwd isEqualToString:self.oldPwdTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"旧密码输入错误！"];
        }else{
            if (![self.sureNewsPwdTextField.text isEqualToString:self.newsPwdTextField.text]) {
                [SVProgressHUD showErrorWithStatus:@"两次输入的新密码不一致!"];
            }else{
                [self changePasswordByInternet];
            }
        }
    }
}

- (void)changePasswordByInternet{
    
    NSString *password = self.oldPwdTextField.text;
    NSString *new_password = self.newsPwdTextField.text;
    NSString *telephone = [ZcxUserDefauts objectForKey:@"telephone"];
    NSDictionary *dict = @{@"roleJudge" : @"PUSHING", @"password" : password , @"new_password" : new_password , @"telephone" : telephone};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/alter_password.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改密码responseObject---%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---%@",error);
    }];
}
@end
