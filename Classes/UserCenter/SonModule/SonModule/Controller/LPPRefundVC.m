//
//  LPPRefundVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/21.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRefundVC.h"
#import "LPPApplyCommodityCell.h"
#import "LPPRefundExpressCell.h"
#import "LPPRefundTypeCell.h"

@interface LPPRefundVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPPRefundVC

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

    self.navigationItem.title = @"退款";
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPApplyCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPApplyCommodityCell" forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 1){
        LPPRefundTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRefundTypeCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.refundDetailLabel.hidden = YES;
            cell.indicatorBtn.hidden = NO;
        }else if (indexPath.row == 1){
            cell.refundTitleLabel.text = @"退款金额:";
            cell.indicatorBtn.hidden = YES;
            cell.refundDetailLabel.text = @"$ 8760.00";
        }else{
            cell.refundTitleLabel.text = @"快递单号:";
            cell.indicatorBtn.hidden = YES;
            cell.refundDetailLabel.text = @"MH23892497240";
            cell.refundDetailLabel.textColor = [UIColor grayColor];
        }
        return cell;
    }else{
        LPPRefundExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRefundExpressCell" forIndexPath:indexPath];
        cell.expressTitleLabel.hidden = YES;
        cell.expressNumLabel.hidden = YES;
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1) {
        return 50;
    }else{
        return 380;
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPRefundTypeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPRefundTypeCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
