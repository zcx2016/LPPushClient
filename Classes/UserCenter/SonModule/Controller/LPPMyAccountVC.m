//
//  LPPMyAccountVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyAccountVC.h"
#import "LPPMyAccountCell.h"
#import "LPPMyAccountHeadView.h"

@interface LPPMyAccountVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPPMyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"我的账户";
    
    [self tableView];
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
    LPPMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPMyAccountCell" forIndexPath:indexPath];
    //隐藏tableViewCell的分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 250;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        LPPMyAccountHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPMyAccountHeadView"];
        if (!headView) {
            headView = [[LPPMyAccountHeadView alloc] initWithReuseIdentifier:@"LPPMyAccountHeadView"];
        }
        return headView;
    }else{
        return [[UIView alloc] init];
    }
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
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyAccountCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPMyAccountCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyAccountHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPMyAccountHeadView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



@end
