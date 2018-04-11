//
//  LPPUserCenterVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUserCenterVC.h"
#import "LPPUserCenterHeadView.h"
#import "LPPUserCenterCell.h"
#import "LPPUserCenterFooterView.h"
#import "LPPCommonTBCell.h"
//点击跳转
#import "LPPMyShippingAddressVC.h"
#import "LPPMyInfoVC.h"
#import "LPPMyOrderVC.h"
#import "LPPMessageVC.h"

#import "LPPCommodityDetailVC.h"

@interface LPPUserCenterVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString  *userName;
@property (nonatomic, copy) NSString  *storeName;
//系统消息数量
@property (nonatomic, copy) NSString  *systemMessage;
@end

@implementation LPPUserCenterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    //设置导航栏
    [self setNav];
    //懒加载tableView
    [self tableView];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"user_id" : user_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/index.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"-个人中心---%@",responseObject);
        self.userName = responseObject[@"userName"];
        self.storeName = responseObject[@"storeName"];
        self.systemMessage = responseObject[@"systemMessage"];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)setNav{
    
    //提醒按钮
    UIButton *remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [remindBtn setImage:[UIImage imageNamed:@"bell"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
    //点击事件
    [remindBtn addTarget:self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 导航栏按钮点击事件
- (void)remindBtnClick:(UIButton *)btn{
  
    LPPMessageVC *messageVc = [LPPMessageVC new];
    [self.navigationController pushViewController:messageVc animated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        LPPUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPUserCenterCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.diyTitleLabel.text = @"我的收货地址";
            cell.diyDetailLabel.hidden = YES;
        }else{
            cell.diyTitleLabel.text = @"我的订单";
            cell.diyDetailLabel.text = @"查看全部订单";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {  //我的收货地址
        
        LPPMyShippingAddressVC *myShipAddressVc = [LPPMyShippingAddressVC new];
        [self.navigationController pushViewController:myShipAddressVc animated:YES];
        
    }else if (indexPath.row == 1){  //我的订单
        LPPMyOrderVC *myOrderVc = [LPPMyOrderVC new];
        [self.navigationController pushViewController:myOrderVc animated:YES];
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 80;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 190+64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LPPUserCenterHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPUserCenterHeadView"];
    if (!headView) {
        headView = [[LPPUserCenterHeadView alloc] initWithReuseIdentifier:@"LPPUserCenterHeadView"];
    }
    [headView.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    headView.headIcon.userInteractionEnabled = YES;
    
    headView.nameLabel.text = self.userName;
    headView.addressLabel.text = self.storeName;
    
    [headView.headIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvents:)]];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 点击编辑按钮
- (void)editBtnClick:(UIButton *)btn{
    LPPMyInfoVC *myInfoVc = [LPPMyInfoVC new];
    [self.navigationController pushViewController:myInfoVc animated:YES];
}

- (void)tapEvents:(UITapGestureRecognizer *)recognizer{
    LPPMyInfoVC *myInfoVc = [LPPMyInfoVC new];
    [self.navigationController pushViewController:myInfoVc animated:YES];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell  LPPRefundTypeCell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPUserCenterCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPUserCenterCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCommonTBCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPUserCenterHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPUserCenterHeadView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //调数据
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //  如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

@end
