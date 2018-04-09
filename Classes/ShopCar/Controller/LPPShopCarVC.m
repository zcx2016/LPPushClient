//
//  LPPShopCarVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPShopCarVC.h"
#import "LPPShopCarCell.h"
#import "LPPShopCarBottomView.h"
#import "LPPWriteOrderVC.h"
#import "LPPShopCarModel.h"

@interface LPPShopCarVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPShopCarBottomView *shopCarBottomView;

@property (nonatomic, weak) LPPShopCarCell *weak_shopCarCell;

@property (nonatomic, strong) UIView  *barView;

@property (nonatomic, strong) NSArray <LPPShopCarModel *>*dataSource;

@end

@implementation LPPShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"购物袋";
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    self.barView.backgroundColor = ZCXColor(225, 61, 38);
    [self.navigationController.navigationBar addSubview:self.barView];
    
    //编辑按钮
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    //点击事件
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self shopCarBottomView];
    
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token,@"pageNo" : @"0" , @"pageSize" : @"0"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/goods_cart1.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-购物车---%@",responseObject);
        NSArray *dataArray = responseObject[@"cart_list"];
        self.dataSource = [NSArray yy_modelArrayWithClass:[LPPShopCarModel class] json:dataArray];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

//导航栏渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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

- (void)editBtnClick:(UIButton *)btn{

    if (!btn.selected) {
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [self.shopCarBottomView.goToBuyBtn setTitle:@"删除" forState:UIControlStateNormal];
        //先删除之前的点击响应事件
        [self.shopCarBottomView.goToBuyBtn removeTarget:self action:@selector(goToBuyEvents:) forControlEvents:UIControlEventTouchUpInside];
        //再添加新的点击响应事件
        [self.shopCarBottomView.goToBuyBtn addTarget:self action:@selector(deleteEvents:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = !btn.selected;
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.shopCarBottomView.goToBuyBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [self.shopCarBottomView.goToBuyBtn addTarget:self action:@selector(goToBuyEvents:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = !btn.selected;
    }
}

- (void)deleteEvents:(UIButton *)btn{
    NSLog(@"删除商品");
}

- (void)goToBuyEvents:(UIButton *)btn{
    LPPWriteOrderVC *writeOrderVc = [LPPWriteOrderVC new];
    [self.navigationController pushViewController:writeOrderVc animated:YES];
}

- (LPPShopCarBottomView *)shopCarBottomView{
    if (!_shopCarBottomView) {
        _shopCarBottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPShopCarBottomView" owner:nil options:nil].lastObject;
        if(self.isFromCommodityDetailVc == 1){
            _shopCarBottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        }else{
            _shopCarBottomView.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 50);
        }
        [self.shopCarBottomView.goToBuyBtn addTarget:self action:@selector(goToBuyEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_shopCarBottomView];
    }
    return _shopCarBottomView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPPShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPShopCarCell" forIndexPath:indexPath];
    //赋值引用
    self.weak_shopCarCell = cell;
    LPPShopCarModel *model = self.dataSource[indexPath.section];
    cell.model  = model;
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 左滑删除
//添加编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//左滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//删除所做的动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 从数据源中删除
//    [_data removeObjectAtIndex:indexPath.row];
    // 从列表中删除---不能直接写，要配合数据源刷新
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11.0) {
            if (self.isFromCommodityDetailVc == 1) {
                _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
            }else{
                _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50-44) style:UITableViewStyleGrouped];
            }
        }else{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
        }

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPShopCarCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPShopCarCell"];
        
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.tableView.layer.contents = (id)image.CGImage;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏下面边界黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
}
@end
