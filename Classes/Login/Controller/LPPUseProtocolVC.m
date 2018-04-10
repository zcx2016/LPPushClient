//
//  LPPUseProtocolVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUseProtocolVC.h"
#import <WebKit/WebKit.h>

@interface LPPUseProtocolVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView  *webView;

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
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    
    [self loadData];
}

- (void)setWKWebView{
    self.webView = [[UIWebView  alloc]init];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).with.offset(5);
        make.right.bottom.equalTo(self.contentView).with.offset(-5);
    }];
    self.webView.delegate = self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView sizeToFit];

    [self.webView loadHTMLString:self.webStr baseURL:nil];
}

- (void)loadData{
    NSDictionary *dict = @{@"userType" : @"0"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/admin/user_protocol_Ajaxlist.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.webStr = responseObject[@"用户协议"];
        [self setWKWebView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)backBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
