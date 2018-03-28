//
//  SCMainTabBarC.m
//  SceneCloudClient
//
//  Created by 张晨曦 on 5/18/17.
//  Copyright © 2017 张晨曦. All rights reserved.
//  TabBar 控制器, 整个项目的根控制器

#import "LPPMainTabBarC.h"

#import <BlocksKit.h>

#import "LPPMainNavC.h"

//#import "SCQuestionManagerVC.h"
//
////lhm
//#import "LBTabBar.h"

@interface LPPMainTabBarC ()/*<LBTabBarDelegate>*/

@property (nonatomic, strong) NSUserDefaults *userDefaults;

//tabbar中间按钮
//@property (nonatomic, strong)  LBTabBar *myTabbar;

@end

@implementation LPPMainTabBarC

+ (void)initialize {
    // 要加这个判断, 不然如果是子类第一次被使用也会调用这个方法
    if (self == [LPPMainTabBarC class]) {
        // 通过appearance统一设置UITabBarItem的文字属性
        // 凡是后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象统一设置
        // normal 状态下的 title 属性
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        // selected 状态下的 title 属性
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:224/255.0 green:62/255.0 blue:40/255.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        // 对所有的 UITabBarItem 对象统一设置
    }
}

#pragma mark - 有聊天版本
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];

    [self setUpChildViewControllers:@"UI.json" UIString:@"UI"];
}

/** 创建所有的子控制器 */
- (void)setUpChildViewControllers:(NSString *)jsonString  UIString:(NSString *)uiString{
    
    // 通过 UI.json 确定界面的显示
    // 获取沙盒中的 UI.json 路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    // 获取 UI.json 文件的数据
    NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:jsonString]];
    // 反序列化得到OC对象
    NSArray *array = nil;
    if (data) { // 获取数据成功
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    } else { // 获取数据失败, 使用 bundle 中的最原始数据
        path = [[NSBundle mainBundle] pathForResource:uiString ofType:@"json"];
        data = [NSData dataWithContentsOfFile:path];
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    
    // 将 NSDictionary 对象 映射为 UIViewController 对象
    self.viewControllers = [array bk_map:^UIViewController *(NSDictionary * obj) {
        return [self setUpOneViewController:obj];
    }];
}

/** 创建一个子控制器 */
- (UIViewController *)setUpOneViewController:(NSDictionary *)vcInfo {
    
    // 获取控制器的类名
    NSString *clsName = vcInfo[@"clsName"];
    if (!clsName) {
        // 获取失败, 返回一个默认的控制器
        return [[NSClassFromString(@"LPPMainNavC") alloc] initWithRootViewController:[UIViewController new]];
    }
    
    // 获取设置控制器需要的其他字段
    NSString *title = vcInfo[@"title"];
    NSString *image = vcInfo[@"image"];
    NSString *selImage = vcInfo[@"selectImage"];
    
    // 返回
    return ({
        // 创建控制器对象
        UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
        vc.title = title;
        if (vc == nil) {
            // 创建失败, 抛出异常
            [NSException exceptionWithName:clsName reason:nil userInfo:nil];
        }
        
        // 包装导航控制器, 并进行设置
        UINavigationController *nav = [[NSClassFromString(@"LPPMainNavC") alloc] initWithRootViewController:vc];
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-4, -4)];
        nav.tabBarItem.image = [UIImage imageNamed:image];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav;
    });
}

#pragma mark - LBTabBarDelegate  lhm
//点击中间按钮的代理方法
//- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
//{
//    _myTabbar.plusBtn.selected = YES;
//    self.selectedIndex = 2;
//}
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//
//    _myTabbar.plusBtn.selected = NO;
//}

@end
