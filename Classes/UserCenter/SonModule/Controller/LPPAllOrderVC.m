//
//  LPPAllOrderVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPAllOrderVC.h"
#import "LPPMyOrderCell.h"
#import "LPPMyOrderView.h"
#import "LPPMyOrderFooterView.h"
#import "LPPLogisticsDetailVC.h"

#import "LPPMyOrderOutModel.h"

@interface LPPAllOrderVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger subViewCount;

@property (nonatomic, strong) NSArray <LPPMyOrderOutModel *>  *outDataSource;

@property (nonatomic, strong) NSArray *originArray;

@property (nonatomic, strong) NSArray *tempHeightArr;

@end

@implementation LPPAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.originArray = [NSArray array];
    self.tempHeightArr = [NSArray array];
    
    self.subViewCount = 2;

    [self tableView];
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"user_id" : user_id , @"order_cat" : @"0"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/goods_order.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-所有订单---%@",responseObject);
        self.originArray = responseObject[@"allOrderList"];
        self.outDataSource = [NSArray yy_modelArrayWithClass:[LPPMyOrderOutModel class] json:self.originArray];
        
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.outDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPPMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPMyOrderCell" forIndexPath:indexPath];
    LPPMyOrderOutModel *model = self.outDataSource[indexPath.section];
    cell.model = model;
    cell.count = self.subViewCount;
    cell.dataSource = self.originArray[indexPath.section][@"goods_infos"];
//    self.tempHeightArr = self.originArray[indexPath.section][@"goods_infos"];
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 160 * self.subViewCount + 50;
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
    [footView.cancelOrderBtn addTarget:self action:@selector(watchLogistics:) forControlEvents:UIControlEventTouchUpInside];
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
