//
//  LPPReturnAfterSaleVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPReturnAfterSaleVC.h"
#import "LPPReturnAfterSaleCell.h"
#import "LPPASHeadTagView.h"

@interface LPPReturnAfterSaleVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPASHeadTagView *headTagView;
@end

@implementation LPPReturnAfterSaleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"退换/售后";
    [self headTagView];
    [self tableView];
}

- (LPPASHeadTagView *)headTagView{
    if (!_headTagView) {
        _headTagView = [[NSBundle mainBundle] loadNibNamed:@"LPPASHeadTagView" owner:nil options:nil].lastObject;
        _headTagView.frame = CGRectMake(0, 64, kScreenWidth, 50);
        _headTagView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_headTagView];
    }
    return _headTagView;
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
    LPPReturnAfterSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPReturnAfterSaleCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, kScreenWidth, kScreenHeight-114) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPReturnAfterSaleCell class]) bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"LPPReturnAfterSaleCell"];
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.view.layer.contents = (id)image.CGImage;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


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

@end
