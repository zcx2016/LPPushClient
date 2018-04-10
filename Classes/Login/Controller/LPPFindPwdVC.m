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
    
    self.sureFindBackBtn.layer.cornerRadius = 5;
    self.sureFindBackBtn.layer.masksToBounds = YES;
    
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //发送验证码
    [self.sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCodeEvents) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendVerifyCodeEvents{
    NSDictionary *dict = @{@"mobile" : self.phoneNumTextField.text , @"type" : @"3"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/send_register_code.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-手机发送找回密码。验证码---%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)backBtnClick:(UIButton *)btn{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
