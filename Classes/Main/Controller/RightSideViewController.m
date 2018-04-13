//
//  RightSideViewController.m
//  ViewDeckStudy
//
//  Created by Mr_M on 2017/6/19.
//  Copyright © 2017年 Mr_M. All rights reserved.
//

#import "RightSideViewController.h"
#import "AppDelegate.h"
#import "LPPFilterBottomView.h"
#import "LPPFilterFirstCell.h"
#import "LPPFilterHeadView.h"
#import "LPPFiltBrandCell.h"
#import "LPPFiltCategoryCell.h"

//点击 完成 ，跳转
#import "LPPGoodsListVC.h"

@interface RightSideViewController ()<UITableViewDelegate,UITableViewDataSource,LPPFilterFirstCellDelegate,LPPFiltBrandCellDelegate,LPPFiltCategoryCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPFilterBottomView *bottomView;

@property (nonatomic, strong) NSArray *brandArr;
@property (nonatomic, strong) NSArray *classArr;

@property (nonatomic, assign) CGFloat brandHeight;
@property (nonatomic, assign) CGFloat classHeight;

//传值
@property (nonatomic, copy) NSString  *priceUpOrDown;
@property (nonatomic, copy) NSString  *brandNames;
@property (nonatomic, copy) NSString  *catNames;

//
@property (nonatomic, strong) LPPFilterFirstCell *weak_cell;
@end

@implementation RightSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.priceUpOrDown = @"";
    self.brandNames = @"";
    self.catNames = @"";
    
    //设置尺寸
    self.preferredContentSize = CGSizeMake(kScreenWidth/6*5, kScreenHeight);
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //初始化数组
    self.brandArr = [NSArray array];
    self.classArr = [NSArray array];
    
    //设置左右BarButtonItem
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"filtCloseBtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(closePopView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self bottomView];
    
    [self tableView];
    
    [self loadData];
}

- (void)loadData{
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/filter.htm"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.brandArr = responseObject[@"brandlist"];
        self.classArr = responseObject[@"classlist"];
        self.brandHeight = 40 * self.brandArr.count /4+ 70;
        self.classHeight = 70 * self.classArr.count /4 + 70;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}


- (LPPFilterBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPFilterBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        //重置
        [_bottomView.resetBtn addTarget:self action:@selector(resetEvents) forControlEvents:UIControlEventTouchUpInside];
        //完成
        [_bottomView.doneBtn addTarget:self action:@selector(doneEvents) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)resetEvents{
    [self.weak_cell.upBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
    [self.weak_cell.downBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    self.priceUpOrDown = @"";
    //重新加载界面
    [self loadData];
}

- (void)doneEvents{

    NSDictionary *dict = @{@"priceUpOrDown" : self.priceUpOrDown , @"brandNames" : self.brandNames , @"catNames" : self.catNames};
    NSLog(@"完成dict-----%@",dict);
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/filter_search.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *arr = responseObject[@"json_list"];
        //关闭抽屉
        [self.viewDeckController closeSide:YES];
        
        //发送通知给 推荐vc。由推荐vc推出商品列表vc
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToGoodsListVc" object:nil userInfo:@{@"arr" : arr}];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma mark - 几个自定义delegate
- (void)pickUpOrDown:(NSInteger)num{
    if (num == 0) {
        self.priceUpOrDown = @"up";
    }else{
        self.priceUpOrDown = @"down";
    }
    NSLog(@"priceUpOrDown---%@",_priceUpOrDown);
}

- (void)pickBrand:(NSString *)name{
    self.brandNames = name;
    NSLog(@"self.brandNames----%@",self.brandNames);
}

- (void)pickCategory:(NSString *)name{
    self.catNames = name;
    NSLog(@"self.catNames----%@",self.catNames);
}

// 关闭抽屉
-(void)closePopView{
    [self.viewDeckController closeSide:YES];
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
    if (indexPath.section == 0) {
        LPPFilterFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPFilterFirstCell" forIndexPath:indexPath];
        self.weak_cell = cell;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        LPPFiltBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPFiltBrandCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.brandListArray = self.brandArr;
        cell.brandHeight = self.brandHeight;
        return cell;
    }else{
        LPPFiltCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPFiltCategoryCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.classListArray = self.classArr;
        cell.classHeight = self.classHeight;
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 1){
        return self.brandHeight;
    }else {
        return self.classHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }else{
        LPPFilterHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPFilterHeadView"];
        if (!headView) {
            headView = [[LPPFilterHeadView alloc] initWithReuseIdentifier:@"LPPFilterHeadView"];
        }
        if (section == 1) {
            headView.titleLabel.text = @"品牌";
        }else{
            headView.titleLabel.text = @"类别";
        }
        return headView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/6*5, kScreenHeight-50-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFilterFirstCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPFilterFirstCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFiltBrandCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPFiltBrandCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFiltCategoryCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPFiltCategoryCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPFilterHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPFilterHeadView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
