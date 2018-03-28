//
//  LPPWaitReceiveOrderVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWaitReceiveOrderVC.h"
#import "LPPMyOrderCell.h"
#import "LPPMyOrderView.h"
#import "LPPMyOrderFooterView.h"
#import "LPPLogisticsDetailVC.h"

@interface LPPWaitReceiveOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger subViewCount;

@end

@implementation LPPWaitReceiveOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calculateViewCount];
    
    self.subViewCount = 2;
    
    [self tableView];
}

//计算view数量
- (void)calculateViewCount{
    
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPPMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPMyOrderCell" forIndexPath:indexPath];
    cell.orderStateLabel.text = @"待收货";
    cell.count = self.subViewCount;
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = self.subViewCount * 160 + 20;
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LPPMyOrderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPMyOrderFooterView"];
    if (!footView) {
        footView = [[LPPMyOrderFooterView alloc] initWithReuseIdentifier:@"LPPMyOrderFooterView"];
    }
    [footView.cancelOrderBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [footView.cancelOrderBtn addTarget:self action:@selector(watchLogistics:) forControlEvents:UIControlEventTouchUpInside];
    [footView.goToPayBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    return footView;
}

- (void)watchLogistics:(UIButton *)btn{
    LPPLogisticsDetailVC *vc = [LPPLogisticsDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-170) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPMyOrderCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyOrderFooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPMyOrderFooterView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



@end
