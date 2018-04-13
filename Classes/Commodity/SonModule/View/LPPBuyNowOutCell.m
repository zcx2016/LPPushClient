//
//  LPPBuyNowOutCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPBuyNowOutCell.h"

#import "LPPBuyNowOrderCell.h"
#import "LPPWriteOrderModel.h"

@interface LPPBuyNowOutCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray <LPPWriteOrderModel*> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPPBuyNowOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.masksToBounds = YES;
    
    [self tableView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.dataArray = [NSArray yy_modelArrayWithClass:[LPPWriteOrderModel class] json:self.dataSource];
    if (self.dataArray.count !=0) {
        [self.tableView reloadData];
    }
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPPBuyNowOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPBuyNowOrderCell" forIndexPath:indexPath];
    if (self.dataArray.count!=0) {
        LPPWriteOrderModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 40, kScreenWidth-40, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        //去掉ios7 的separatorInset边距
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPBuyNowOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPBuyNowOrderCell"];
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
