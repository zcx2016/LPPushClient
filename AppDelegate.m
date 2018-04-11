//
//  AppDelegate.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "AppDelegate.h"

#import "RightSideViewController.h"

@interface AppDelegate ()<IIViewDeckControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置状态栏字体颜色为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"writeOrder_bg"]];
    //
    _rootTabbarCtrV = [NSClassFromString(@"LPPMainTabBarC") new];
    //右边
    RightSideViewController *rightView=[[RightSideViewController alloc]init];
    UINavigationController *rightNvi=[[UINavigationController alloc]initWithRootViewController:rightView];
    
    IIViewDeckController *viewDeckController =[[IIViewDeckController alloc]initWithCenterViewController:_rootTabbarCtrV leftViewController:nil rightViewController:rightNvi];
    viewDeckController.delegate=self;
    //由于项目需要---禁止抽屉的左滑右滑效果！
    [viewDeckController.view removeGestureRecognizer:viewDeckController.leftEdgeGestureRecognizer];
    [viewDeckController.view removeGestureRecognizer:viewDeckController.rightEdgeGestureRecognizer];
    
    self.window.rootViewController=viewDeckController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
