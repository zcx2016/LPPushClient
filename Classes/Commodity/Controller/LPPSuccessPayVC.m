//
//  LPPSuccessPayVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPSuccessPayVC.h"
#import "LPPMyOrderVC.h"
#import "LPPCommodityDetailVC.h"

@interface LPPSuccessPayVC ()

@end

@implementation LPPSuccessPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    [self.continueShoppingBtn addTarget:self action:@selector(continueShoppingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.watchOrderBtn addTarget:self action:@selector(watchOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//继续购物
- (void)continueShoppingBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];

//    LPPCommodityDetailVC *vc = [LPPCommodityDetailVC new];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)watchOrderBtnClick:(UIButton *)btn{
    LPPMyOrderVC *vc = [LPPMyOrderVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    UINavigationController *pushNavVc = [[UINavigationController alloc] initWithRootViewController:vc];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn2 setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(backToHomeVc) forControlEvents:UIControlEventTouchUpInside];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    [pushNavVc.navigationBar setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                      }];
    
    
    [self presentViewController:pushNavVc animated:YES completion:nil];
}

//进入通知后，点击返回键，触发的动作
- (void)backToHomeVc{
    
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


@end
