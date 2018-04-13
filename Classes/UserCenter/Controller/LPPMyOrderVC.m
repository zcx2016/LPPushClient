//
//  LPPMyOrderVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderVC.h"

#import "LPPAllOrderVC.h"
#import "LPPWaitPayOrderVC.h"
#import "LPPWaitPostOrderVC.h"
#import "LPPWaitReceiveOrderVC.h"

@interface LPPMyOrderVC ()<LPPMyOrderTopViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

//当前控制器
@property (nonatomic, weak) UIViewController *currentVC;
//
@property (nonatomic, strong) LPPAllOrderVC *allOrderVc;
@property (nonatomic, strong) LPPWaitPayOrderVC *waitPayOrderVc;
@property (nonatomic, strong) LPPWaitPostOrderVC *waitPostOrderVc;
@property (nonatomic, strong) LPPWaitReceiveOrderVC *waitReceiveOrderVc;


@end

@implementation LPPMyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    
    //设置View背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    //头部view
    [self topView];
    
    //创建子控制器
    self.allOrderVc = [LPPAllOrderVC new];
    self.waitPayOrderVc = [LPPWaitPayOrderVC new];
    self.waitPostOrderVc = [LPPWaitPostOrderVC new];
    self.waitReceiveOrderVc = [LPPWaitReceiveOrderVC new];
    
    //添加子控制器
    [self addChildViewController:self.allOrderVc];
    [self addChildViewController:self.waitPayOrderVc];
    [self addChildViewController:self.waitPostOrderVc];
    [self addChildViewController:self.waitReceiveOrderVc];
    
    //默认选择第一个子控制器
    [self fourBtnClick:nil];
    
}



- (LPPMyOrderTopView *)topView{
    if(!_topView){
        _topView = [[NSBundle mainBundle] loadNibNamed:@"LPPMyOrderTopView" owner:nil options:nil].lastObject;
        _topView.frame = CGRectMake(0, 64, kScreenWidth, 100);
        _topView.backgroundColor = [UIColor clearColor];
        //绑定 代理
        _topView.stateSelectedDelegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}

#pragma mark -代理
- (void)fourBtnClick:(UIButton *)btn{
    
    //移除当前显示的控制器
    [self.currentVC.view removeFromSuperview];
    //获得控制器的位置索引
//    NSUInteger index = [btn.superview.subviews indexOfObject:btn];
    NSInteger index = 0 ;
//    index = [btn.superview.subviews indexOfObject:btn];
    //添加控制器View
    
    if (self.btnName.length != 0) {
        if ([self.btnName isEqualToString:@"待付款"]){
            index = 1;
            self.btnName = nil;
        }else if ([self.btnName isEqualToString:@"待发货"]){
            index = 2;
            self.btnName = nil;
        }else{
            index = 3;
            self.btnName = nil;
        }
    }else{
        NSString *curTitle = btn.currentTitle;
        if([curTitle isEqualToString:@"全部"]){
            index = 0;
        }else if ([curTitle isEqualToString:@"待付款"]){
            index = 1;
        }else if ([curTitle isEqualToString:@"待发货"]){
            index = 2;
        }else{
            index = 3;
        }
    }
    
    self.currentVC = self.childViewControllers[index];
    //设置尺寸
    self.currentVC.view.frame = CGRectMake(0, 50+114, kScreenWidth, kScreenHeight - 114-114);
    //添加到控制器上
    [self.view addSubview:self.currentVC.view];
}

#pragma mark- 导航栏透明
- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

@end
