//
//  LPPRegisterVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRegisterVC.h"

@interface LPPRegisterVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

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
}

- (void)backBtnClick:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerEvents:(UIButton *)btn{
    NSString *password = self.pwdNumTextField.text;
    
    NSDictionary *dict = @{};
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/register_finish.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject----%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@",error);
    }];
}
@end
