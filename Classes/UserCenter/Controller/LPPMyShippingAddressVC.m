//
//  LPPMyShippingAddressVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyShippingAddressVC.h"
#import "LPPMyShippingAddressCell.h"
#import "LPPCreateNewAddressVC.h"
#import "LPPEditOldAddressVC.h"
#import "LPPAddressSearchCell.h"
#import "LPPMyShippingAddressModel.h"

@interface LPPMyShippingAddressVC ()<UITableViewDataSource,UITableViewDelegate,LPPMyShippingAddressCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<LPPMyShippingAddressModel *> *dataSource;

@end

@implementation LPPMyShippingAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"管理收货地址";
    
    [self tableView];
    [self setBottomBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token , @"trueName" : @"" , @"telephone" : @""};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-收货地址列表---%@",responseObject);
        NSArray *dataArray = responseObject[@"address_list"];
        self.dataSource = [NSArray yy_modelArrayWithClass:[LPPMyShippingAddressModel class] json:dataArray];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma mark - 设置 底部按钮
- (void)setBottomBtn{
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [bottomBtn setTitle:@"新建地址" forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:ZCXColor(242, 69, 60)];
    //点击事件
    [bottomBtn addTarget:self action:@selector(createNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

#pragma mark - 创建新地址
- (void)createNewAddress{
    LPPCreateNewAddressVC *createNewAddressVc = [LPPCreateNewAddressVC new];
    [self.navigationController pushViewController:createNewAddressVc animated:YES];
}

#pragma mark - 实现 点击编辑按钮 代理
- (void)isEditBtnClick:(UIButton *)btn{
    //获得点击btn所在的cell
    LPPMyShippingAddressCell *cell = (LPPMyShippingAddressCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LPPMyShippingAddressModel *model = [self.dataSource objectAtIndex:indexPath.section - 1];
    
    LPPEditOldAddressVC *vc = [LPPEditOldAddressVC new];
    vc.addr_id = model.addr_id;
    vc.areaAddr = model.areaAddr;
    vc.areaInfo = model.areaInfo;
    vc.telephone = model.telephone;
    vc.trueName = model.trueName;
    vc.idcardback = model.idcardback;
    vc.idcardfond = model.idcardfond;
    vc.defaultNum = model.defaultNum;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 实现 点击删除按钮 代理
- (void)isDeleteBtnClick:(UIButton *)btn{
    
    //获得btn所在的cell
    LPPMyShippingAddressCell *cell = (LPPMyShippingAddressCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LPPMyShippingAddressModel *cellModel = [self.dataSource objectAtIndex:indexPath.section -1];
    //获得删除某一个cell的专属ID
    NSString *addr_id = cellModel.addr_id;
    
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token , @"addr_id" : addr_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new_delete.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //删除数据
        NSMutableArray *tempArray = [self.dataSource mutableCopy];
        [tempArray removeObjectAtIndex:indexPath.section -1];
        
        //将数组重新赋值回去
        self.dataSource = [tempArray copy];
        
        //刷新数据源
        [self.tableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

#pragma mark - 实现 点击默认地址按钮 代理
- (void)isDefaultAddressBtnClick:(UIButton *)btn{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    
    //获得btn所在的cell
    LPPMyShippingAddressCell *cell = (LPPMyShippingAddressCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LPPMyShippingAddressModel *cellModel = [self.dataSource objectAtIndex:indexPath.section -1];
    //获得删除某一个cell的专属ID
    NSString *addr_id = cellModel.addr_id;
    
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token ,@"addr_id" : addr_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new_default_set.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //刷新数据
        [self loadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPAddressSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressSearchCell" forIndexPath:indexPath];
        return cell;
    }else{
        LPPMyShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPMyShippingAddressCell" forIndexPath:indexPath];
        LPPMyShippingAddressModel *model = [self.dataSource objectAtIndex:indexPath.section - 1];
        cell.model = model;
        if([model.defaultNum isEqualToString:@"1"]){  //默认，则按钮变色
            [cell.defaultAddressBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            cell.defaultAddressBtn.selected = YES;
        }else{
            [cell.defaultAddressBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        }
        //继承代理
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 120;
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
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPAddressSearchCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPAddressSearchCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyShippingAddressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPMyShippingAddressCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
