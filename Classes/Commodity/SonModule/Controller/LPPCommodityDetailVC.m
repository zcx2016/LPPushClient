//
//  LPPCommodityDetailVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCommodityDetailVC.h"
#import "LPPCDTopImgViewCell.h"
#import "LPPCDPriceNameCell.h"
#import "LPPCDCommodityStyleCell.h"
#import "LPPCDComparePriceCell.h"
#import "LPPCDCommodityInfoCell.h"
#import "LPPCDImgIntroductCell.h"
#import "LPPCommodityDetailBottomView.h"

#import "ZCXActionSheetView.h"

@interface LPPCommodityDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPCommodityDetailBottomView *bottomView;

@property (nonatomic, strong) UIView *barView;

@end

@implementation LPPCommodityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"商品详情";
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    self.barView.backgroundColor = ZCXColor(225, 61, 38);
    [self.navigationController.navigationBar addSubview:self.barView];
    
    [self tableView];
    
    [self bottomView];
    
    //分享按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"sharePost"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *color= ZCXColor(225, 61, 38);
    CGFloat offset=scrollView.contentOffset.y;
    
    if (offset<0) {
        
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
        self.barView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((64-offset)/64);
        self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
        self.barView.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)shareBtnClick:(UIButton *)btn{

    ZCXActionSheetView *sheet = [[ZCXActionSheetView alloc] initWithActionSheet];
    //放在最上层
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:sheet];
}

- (LPPCommodityDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPCommodityDetailBottomView" owner:nil options:nil].lastObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row== 0) {
            LPPCDTopImgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDTopImgViewCell" forIndexPath:indexPath];
            
            return cell;
        }else if (indexPath.row == 1) {
            LPPCDPriceNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDPriceNameCell" forIndexPath:indexPath];
            
            return cell;
        }else if(indexPath.row == 2){
            LPPCDCommodityStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDCommodityStyleCell" forIndexPath:indexPath];
            
            return cell;
        }else{
            LPPCDComparePriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDComparePriceCell" forIndexPath:indexPath];
            
            return cell;
        }
        
    }else if (indexPath.section == 1){
        LPPCDCommodityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDCommodityInfoCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPCDImgIntroductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDImgIntroductCell" forIndexPath:indexPath];
        [cell.scrollToTopBtn addTarget:self action:@selector(scrollToTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

#pragma mark - 按钮触发scrollToTop功能
- (void)scrollToTopBtnClick:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 250;
        }else if (indexPath.row == 1) {
            return 100;
        }else if (indexPath.row == 2){
            return 190;
        }else{
            return 180;
        }
    }else if (indexPath.section == 1){
        return 180;
    }else{
        return 640;
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
    grayView.backgroundColor  = ZCXColor(241, 243, 247);
    return grayView;
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDTopImgViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDTopImgViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDPriceNameCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDPriceNameCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDCommodityStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDCommodityStyleCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDComparePriceCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDComparePriceCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDCommodityInfoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDCommodityInfoCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDImgIntroductCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDImgIntroductCell"];
        
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.view.layer.contents = (id)image.CGImage;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end