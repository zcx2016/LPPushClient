//
//  LPPExchangeGoodsVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/21.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPExchangeGoodsVC.h"
#import "LPPApplyCommodityCell.h"
#import "LPPRefundExpressCell.h"

@interface LPPExchangeGoodsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPPExchangeGoodsVC

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

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.navigationItem.title = @"换货";
    
    [self tableView];
    
    [self setBottomBtn];
}

- (void)setBottomBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setBackgroundColor:ZCXColor(242, 69, 60)];
    [self.view addSubview:btn];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPApplyCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPApplyCommodityCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPRefundExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRefundExpressCell" forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else{
        return 160+250;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    [grayView setBackgroundColor:ZCXColor(241, 243, 248)];
    return grayView;
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _tableView.layer.contents = (id)image.CGImage;
        
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPApplyCommodityCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPApplyCommodityCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPRefundExpressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPRefundExpressCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



@end
