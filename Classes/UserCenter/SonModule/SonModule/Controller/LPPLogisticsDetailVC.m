//
//  LPPLogisticsDetailVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPLogisticsDetailVC.h"
#import "LPPLogisticsAddressCell.h"
#import "LPPLogisticsProgressCell.h"
#import "LPPLogisticsDetailTopView.h"

@interface LPPLogisticsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPLogisticsDetailTopView *topView;

@property (nonatomic, assign) NSInteger rowCount;

@end

@implementation LPPLogisticsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"物流详情";
    self.view.backgroundColor =ZCXColor(241, 243, 248);
    
    [self topView];
    [self tableView];
    
    self.rowCount = 4;
}

- (LPPLogisticsDetailTopView *)topView{
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"LPPLogisticsDetailTopView" owner:nil options:nil].lastObject;
        _topView.frame = CGRectMake(0, 0, kScreenWidth, 224);
        //设置背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _topView.layer.contents = (id)image.CGImage;
        
        [self.view addSubview:_topView];
    }
    return _topView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowCount;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LPPLogisticsAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPLogisticsAddressCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPLogisticsProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPLogisticsProgressCell" forIndexPath:indexPath];
        
        if (indexPath.row == 1) {
            cell.timeLabel.textColor = [UIColor redColor];
            cell.upLineView.hidden = YES;
            cell.midCircleView.backgroundColor = [UIColor redColor];
            cell.midCircleView.layer.borderColor = [UIColor redColor].CGColor;
            cell.transportStateLabel.textColor = [UIColor redColor];
        }else if (indexPath.row == self.rowCount -1){
            cell.timeLabel.textColor = [UIColor lightGrayColor];
            cell.downLineView.hidden = YES;
            cell.midCircleView.backgroundColor = [UIColor whiteColor];
            cell.midCircleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.transportStateLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.timeLabel.textColor = [UIColor lightGrayColor];
            cell.upLineView.hidden = NO;
            cell.midCircleView.backgroundColor = [UIColor whiteColor];
            cell.midCircleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.transportStateLabel.textColor = [UIColor lightGrayColor];
        }
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 150;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64+130+40, kScreenWidth-20, kScreenHeight  - 64-130-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius =3;
        _tableView.layer.masksToBounds = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPLogisticsAddressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPLogisticsAddressCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPLogisticsProgressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPLogisticsProgressCell"];
        
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
