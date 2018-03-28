//
//  LPPCompleteInfoVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCompleteInfoVC.h"
#import "LPPCompleteInfoView.h"

@interface LPPCompleteInfoVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) LPPCompleteInfoView *completeInfoView;

@end

@implementation LPPCompleteInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"完善资料";
    self.view.backgroundColor = ZCXColor(241, 243, 248);
    
    [self scrollView];
    [self completeInfoView];
}

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

- (LPPCompleteInfoView *)completeInfoView{
    if (!_completeInfoView) {
        _completeInfoView = [[NSBundle mainBundle] loadNibNamed:@"LPPCompleteInfoView" owner:nil options:nil].lastObject;
        _completeInfoView.frame = CGRectMake(0, 0, kScreenWidth,  kScreenHeight);
        [self.scrollView addSubview:_completeInfoView];
    }
    return _completeInfoView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight+64)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+100+64);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



@end
