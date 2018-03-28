//
//  LPPWriteOrderVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWriteOrderVC.h"
#import "LPPWriteOrderAddressCell.h"
#import "LPPWriteOrderCommodityCell.h"
#import "LPPWriteOrderBottomView.h"
#import "LPPPayMethodFooterView.h"
#import "LPPWriteOrderAddressModel.h"
#import "LPPSuccessPayVC.h"

@interface LPPWriteOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPWriteOrderBottomView *writeOrderBottomView;

@property (nonatomic, assign) NSInteger subViewCount;

@property (nonatomic, strong) UIView *barView;

@property (nonatomic, strong) NSDictionary *addressDataSource;

@end

@implementation LPPWriteOrderVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"填写订单";
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    self.barView.backgroundColor = ZCXColor(225, 61, 38);
    [self.navigationController.navigationBar addSubview:self.barView];
    
    self.subViewCount = 2;
    [self calculateViewCount];
    
    [self tableView];
    [self writeOrderBottomView];
    
    //加载地址栏数据
    [self loadAddressData];
}

- (void)loadAddressData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new_default.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"---responseObject -- %@",responseObject);
        self.addressDataSource = responseObject;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

//计算view数量
- (void)calculateViewCount{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"offset---scroll:%f",self.tableView.contentOffset.y);
    UIColor *color= ZCXColor(225, 61, 38);
    CGFloat offset=scrollView.contentOffset.y;

    if (offset<0) {
        
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
        self.barView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((64-offset)/64);
        self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
        self.barView.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
}

- (LPPWriteOrderBottomView *)writeOrderBottomView{
    if (!_writeOrderBottomView) {
        _writeOrderBottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPWriteOrderBottomView" owner:nil options:nil].lastObject;
        _writeOrderBottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        [_writeOrderBottomView.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_writeOrderBottomView];
    }
    return _writeOrderBottomView;
}

- (void)payBtnClick:(UIButton *)btn{
    
    LPPSuccessPayVC *vc = [LPPSuccessPayVC new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPWriteOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPWriteOrderAddressCell" forIndexPath:indexPath];
        cell.receiverLabel.text = self.addressDataSource[@"trueName"];
        cell.phoneNumLabel.text = self.addressDataSource[@"telephone"];
        cell.addressLabel.text = [self.addressDataSource[@"areaAddr"] stringByAppendingString:self.addressDataSource[@"areaInfo"]];
        
        return cell;
    }else{
        LPPWriteOrderCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPWriteOrderCommodityCell" forIndexPath:indexPath];
        cell.count = self.subViewCount;
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else{
        CGFloat h = self.subViewCount * 150+20;
        return h;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }else{
        LPPPayMethodFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPPayMethodFooterView"];
        if (!footView) {
            footView = [[LPPPayMethodFooterView alloc] initWithReuseIdentifier:@"LPPPayMethodFooterView"];
        }
        return footView;
    }
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _tableView.layer.contents = (id)image.CGImage;
        
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPWriteOrderAddressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPWriteOrderAddressCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPWriteOrderCommodityCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPWriteOrderCommodityCell"];
        //注册footView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPPayMethodFooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPPayMethodFooterView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
