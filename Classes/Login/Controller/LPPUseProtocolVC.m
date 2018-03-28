//
//  LPPUseProtocolVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUseProtocolVC.h"
#import <WebKit/WebKit.h>

@interface LPPUseProtocolVC ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString  *webStr;

@end

@implementation LPPUseProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;

    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentTextView.layer.cornerRadius = 5;
    self.contentTextView.layer.masksToBounds = YES;
    
    [self loadData];
}

- (void)setWKWebView{
    self.webView = [[WKWebView alloc]init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
//    [self.webView loadHTMLString:self.webStr baseURL:nil];
    [self.webView evaluateJavaScript:self.webStr completionHandler:^(id _Nullable data,NSError * _Nullable error) {
        
    }];
}

- (void)loadData{
    NSDictionary *dict = @{@"userType" : @"0"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/admin/user_protocol_Ajaxlist.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-responseObject---%@",responseObject);
        self.webStr = responseObject;
        [self setWKWebView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)backBtnClick:(UIButton *)btn{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
