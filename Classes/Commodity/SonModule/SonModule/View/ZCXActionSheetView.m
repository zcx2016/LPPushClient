//
//  ZCXActionSheetView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetView.h"
#import "ZCXActionSheetTabVCell.h"
#import "ZCXActionSheetHeadView.h"
#import "ZCXActionSheetFootView.h"

@interface ZCXActionSheetView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *maskView;//背景
@end

@implementation ZCXActionSheetView

- (instancetype)initWithActionSheet{
    self = [super init];
    if(self){
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.tableView];
    }
    return self;
}

//背景
- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.userInteractionEnabled = YES;
        _maskView.alpha = 0.5;
        [self addSubview:_maskView];
    }
    return _maskView;
}

#pragma mark ------ 绘制视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}

//滑动弹出
- (void)show {
    
    _tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 485);
    
    [UIView animateWithDuration:.5 animations:^{

        CGRect rect = _tableView.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        _tableView.frame = rect;
    }];
}

//滑动消失
- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y += _tableView.bounds.size.height;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ------ 触摸屏幕其他位置弹下
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"event---%@",event);
    [self dismiss];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZCXActionSheetTabVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZCXActionSheetTabVCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        return cell;
    }
}

- (void)cancelBtnClick:(UIButton *)btn{
    [self dismiss];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 220;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 90;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 130;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        ZCXActionSheetHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZCXActionSheetHeadView"];
        if (!headView) {
            headView = [[ZCXActionSheetHeadView alloc] initWithReuseIdentifier:@"ZCXActionSheetHeadView"];
        }
        return headView;
    }
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        ZCXActionSheetFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZCXActionSheetFootView"];
        if (!footView) {
            footView = [[ZCXActionSheetFootView alloc] initWithReuseIdentifier:@"ZCXActionSheetFootView"];
        }
        return footView;
    }
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCXActionSheetTabVCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZCXActionSheetTabVCell"];
        //注册headView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCXActionSheetHeadView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ZCXActionSheetHeadView"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCXActionSheetFootView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ZCXActionSheetFootView"];
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
