//
//  LPPRecommendVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRecommendVC.h"
#import "LPPRecommendFirstCell.h"
#import "LPPRecommendSecondCell.h"
#import "LPPRecommendFooterView.h"
#import "ATCarouselView.h"
#import "LPPCommodityDetailVC.h"

@interface LPPRecommendVC ()<UITableViewDelegate,UITableViewDataSource,ATCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *imgView2;

@property (nonatomic, strong) ATCarouselView *carouselView;
@end

@implementation LPPRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
//    [self loadData];
    
    [self loadGuiGeData];
}

- (void)loadGuiGeData{
    NSDictionary *dict = @{@"id" : @"38"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/goods_specs.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject--%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSString *ID = @"38";
    NSDictionary *dict = @{@"user_id" : user_id, @"token" : token,@"id" : ID};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/goods.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject--%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];
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
        LPPRecommendFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRecommendFirstCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPRecommendSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRecommendSecondCell" forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 200;
    }
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 510+50;
    }
    return 0.01;
}

#pragma mark - headerFooterView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LunBo"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"LunBo"];
        }
        [view addSubview:[self carouselView]];
        return view;
    }else if (section == 1){
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Cloth"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Cloth"];
        }
        if (self.imgView) {
            [self.imgView removeFromSuperview];
        }
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerCloth"]];
        [view addSubview:self.imgView];
        return view;
    }else{
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Bag"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Bag"];
        }
        if (self.imgView2) {
            [self.imgView2 removeFromSuperview];
        }
        self.imgView2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerBag"]];
        [view addSubview:self.imgView2];
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        LPPRecommendFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPRecommendFooterView"];
        if (!footView) {
            footView = [[LPPRecommendFooterView alloc] initWithReuseIdentifier:@"LPPRecommendFooterView"];
        }
        return footView;
    }
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-104) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.view.layer.contents = (id)image.CGImage;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPRecommendFirstCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPRecommendFirstCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPRecommendSecondCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPRecommendSecondCell"];
        //注册headView
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"LunBo"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"CLoth"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Bag"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPRecommendFooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPRecommendFooterView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//轮播图
- (void)carouselView:(ATCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger )index{
    NSLog(@"点击了第%ld张图片",index);
}

- (ATCarouselView *)carouselView{
    if (!_carouselView) {
        _carouselView = [[ATCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _carouselView.delegate = self;
        _carouselView.images = @[
                                     [UIImage imageNamed:@"bannerHead"],
                                     [UIImage imageNamed:@"bannerBag"],
                                     [UIImage imageNamed:@"bannerKids"],
                                     [UIImage imageNamed:@"bannerMan"]
                                     ];
        //当前选中颜色
        _carouselView.currentPageColor = [UIColor blackColor];
        //普通状态颜色
        _carouselView.pageColor = [UIColor lightGrayColor];
    }
    return _carouselView;
}

@end
