//
//  LPPWriteOrderCommodityCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWriteOrderCommodityCell.h"
#import "LPPWriteOrderCommoditySubView.h"
#import "LPPWriteOrderModel.h"

#import "LPPWriteOrderSubCell.h"

@interface LPPWriteOrderCommodityCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray <LPPWriteOrderModel*> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation LPPWriteOrderCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
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

//@synthesize count = _count;
//- (void)setCount:(NSInteger )count{
//    self.dataArray = [NSArray yy_modelArrayWithClass:[LPPWriteOrderModel class] json:self.dataSource];
//    if (count> 0 && _flag == NO) {
//        _flag = YES;
//        for (int i = 0; i < count; i++) {
//            LPPWriteOrderCommoditySubView *orderView = [[NSBundle mainBundle] loadNibNamed:@"LPPWriteOrderCommoditySubView" owner:nil options:nil].lastObject;
//            orderView.backgroundColor = [UIColor yellowColor];
//            NSLog(@"self.dataArray222=====%@",self.dataArray);
//            if (self.dataArray.count != 0) {
//                LPPWriteOrderModel *model = self.dataArray[i];
//                orderView.model = model;
//            }
//
//            NSLog(@"i=====%d",i);
//            orderView.lineView.hidden = NO;
//            orderView.frame = CGRectMake(10, 30 +140 *i, kScreenWidth- 40, 1);
//            NSLog(@"orderView.frame====%@",orderView);
//            if (i == count - 1) {
//                orderView.lineView.hidden = YES;
//            }
//             [self.outView addSubview:orderView];
//        }
//
//    }
//}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPPWriteOrderSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPWriteOrderSubCell" forIndexPath:indexPath];
    if (self.dataArray.count!=0) {
        LPPWriteOrderModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPWriteOrderSubCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPWriteOrderSubCell"];

        
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
