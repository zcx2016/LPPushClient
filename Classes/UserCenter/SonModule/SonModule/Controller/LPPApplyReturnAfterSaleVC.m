//
//  LPPApplyReturnAfterSaleVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPApplyReturnAfterSaleVC.h"
#import "LPPApplyCommodityCell.h"
#import "LPPApplyServerTypeCell.h"
#import "LPPApplyQuestionDescribeCell.h"

#import "LPPExchangeGoodsVC.h"
#import "LPPRefundVC.h"

@interface LPPApplyReturnAfterSaleVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, weak) LPPApplyServerTypeCell *weak_serverTypeCell;

@end

@implementation LPPApplyReturnAfterSaleVC

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
    
    self.navigationItem.title = @"申请售后";
    
    //默认tag = 1,换货。如果tag=2，退款
    self.tag = 1;
    
    [self tableView];
    
    [self setBottomBtn];
}

- (void)setBottomBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:ZCXColor(242, 69, 60)];
    [self.view addSubview:btn];
}

- (void)submitBtnClick:(UIButton *)btn{
    if(self.tag == 1){
        LPPExchangeGoodsVC *vc = [LPPExchangeGoodsVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LPPRefundVC *vc = [LPPRefundVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        LPPApplyCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPApplyCommodityCell" forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 1){
        LPPApplyServerTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPApplyServerTypeCell" forIndexPath:indexPath];
        //赋值
        self.weak_serverTypeCell = cell;
        //添加点击事件
        [cell.exchangeGoodsBtn addTarget:self action:@selector(exchangeGoodsEvents:) forControlEvents:UIControlEventTouchUpInside];
        [cell.refundBtn addTarget:self action:@selector(refundEvents:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        LPPApplyQuestionDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPApplyQuestionDescribeCell" forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - 换货，退款
- (void)exchangeGoodsEvents:(UIButton *)btn{
    self.tag = 1;
    [self.weak_serverTypeCell.exchangeGoodsBtn setBackgroundImage:[UIImage imageNamed:@"colorBtn"] forState:UIControlStateNormal];
    [self.weak_serverTypeCell.exchangeGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.weak_serverTypeCell.exchangeGoodsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.weak_serverTypeCell.refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.weak_serverTypeCell.refundBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.weak_serverTypeCell.refundBtn setBackgroundImage:nil forState:UIControlStateNormal];
    self.weak_serverTypeCell.refundBtn.layer.borderWidth = 1;
    self.weak_serverTypeCell.refundBtn.layer.cornerRadius = 3;
    self.weak_serverTypeCell.refundBtn.layer.masksToBounds = YES;
}

- (void)refundEvents:(UIButton *)btn{
    self.tag = 2;
    self.weak_serverTypeCell.refundBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.weak_serverTypeCell.refundBtn setBackgroundImage:[UIImage imageNamed:@"colorBtn"] forState:UIControlStateNormal];
    [self.weak_serverTypeCell.refundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.weak_serverTypeCell.exchangeGoodsBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.weak_serverTypeCell.exchangeGoodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.weak_serverTypeCell.exchangeGoodsBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.weak_serverTypeCell.exchangeGoodsBtn.layer.borderWidth = 1;
    self.weak_serverTypeCell.exchangeGoodsBtn.layer.cornerRadius = 3;
    self.weak_serverTypeCell.exchangeGoodsBtn.layer.masksToBounds = YES;

}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1) {
        return 105;
    }else{
        return 300;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPApplyServerTypeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPApplyServerTypeCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPApplyQuestionDescribeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPApplyQuestionDescribeCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
