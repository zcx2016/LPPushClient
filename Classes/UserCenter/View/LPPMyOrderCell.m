//
//  LPPMyOrderCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderCell.h"
#import "LPPMyOrderView.h"

#import "LPPMyOrderSubCell.h"
#import "LPPMyOrderSonModel.h"

@interface LPPMyOrderCell()
/*<UITableViewDataSource,UITableViewDelegate>*/

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <LPPMyOrderSonModel*> *dataArray;
@end

@implementation LPPMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.masksToBounds = YES;
    
//    [self tableView];
}

- (void)setModel:(LPPMyOrderOutModel *)model{
    _model = model;
    if (model.order_num.length != 0) {
        self.orderNumLabel.text = [@"订单号:" stringByAppendingString:model.order_num];
    }
    self.timeLabel.text = model.addTime;
    if ([model.order_status isEqualToString:@"10"]) {
        self.orderStateLabel.text = @"待付款";
    }else if ([model.order_status isEqualToString:@"20"]){
        self.orderStateLabel.text = @"待发货";
    }else if ([model.order_status isEqualToString:@"30"]){
        self.orderStateLabel.text = @"待收货";
    }else{
        self.orderStateLabel.text = @"已收货";
    }
}

@synthesize count = _count;
- (void)setCount:(NSInteger )count{
    if (count> 0 && _flag == NO) {
        _flag = YES;
        for (int i = 0; i < count; i++) {
            LPPMyOrderView *orderView = [[NSBundle mainBundle] loadNibNamed:@"LPPMyOrderView" owner:nil options:nil].lastObject;
            orderView.lineView.hidden = NO;
            orderView.frame = CGRectMake(0, 50 + 150 *i, kScreenWidth- 50, 0);
            if (i == count - 1) {
                orderView.lineView.hidden = YES;
            }
            [self.outView addSubview:orderView];
        }
        
    }
}


//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.dataArray = [NSArray yy_modelArrayWithClass:[LPPMyOrderSonModel class] json:self.dataSource];
//    if (self.dataArray.count !=0) {
//        [self.tableView reloadData];
//    }
//}
//
//#pragma mark - tableView Delegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//#pragma mark - tableView DataSource
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    LPPMyOrderSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPMyOrderSubCell" forIndexPath:indexPath];
//    if (self.dataArray.count!=0) {
//        LPPMyOrderSonModel *model = self.dataArray[indexPath.row];
//        cell.model = model;
//    }
//    return cell;
//}
//
//#pragma mark - 设置行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 150;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}
//
//#pragma mark - 懒加载tableView
//- (UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth-40, self.dataArray.count * 150) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = [UIColor yellowColor];
//        //去掉ios7 的separatorInset边距
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        //注册cell
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPMyOrderSubCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPMyOrderSubCell"];
//
//        [self addSubview:_tableView];
//    }
//    return _tableView;
//}


@end
