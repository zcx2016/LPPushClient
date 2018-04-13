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

#import "LPPSecondCellOutModel.h"
#import "LPPFooterViewModel.h"

#import "LPPGoodsListVC.h"

@interface LPPRecommendVC ()<UITableViewDelegate,UITableViewDataSource,ATCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *imgView2;

@property (nonatomic, strong) ATCarouselView *carouselView;

//轮播数组
@property (nonatomic, strong) NSArray *lunBoArray;
@property (nonatomic, strong) NSMutableArray *imgArray;

//第2，3
@property (nonatomic, strong) NSArray *secondArray;
//footerView
@property (nonatomic, strong) NSArray <LPPFooterViewModel *>*footVModel;
@property (nonatomic, assign) CGFloat footVHeight;

@end

@implementation LPPRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgArray = [NSMutableArray array];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    
    [self tableView];
    
    [self loadLunBoData];
    [self loadSecondCellData];
    [self loadFooterViewData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToGoodsListVcNoti:) name:@"pushToGoodsListVc" object:nil];
}

- (void)pushToGoodsListVcNoti:(NSNotification *)noti{
    NSArray *arr = noti.userInfo[@"arr"];
    LPPGoodsListVC *vc = [LPPGoodsListVC new];
    vc.drawArray = arr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadLunBoData{
    NSDictionary *dict = @{@"id" : self.tagId};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/recommend_adv.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.lunBoArray = responseObject[@"json_list"];
        for (NSDictionary *dict in self.lunBoArray) {
            NSURL *imageUrl = [NSURL URLWithString:dict[@"advPhoto"]];
            [self.imgArray addObject:imageUrl];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadSecondCellData{
    NSDictionary *dict = @{@"id" : self.tagId};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/recommend_big_photo.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.secondArray = responseObject[@"json_list"];

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadFooterViewData{
    NSDictionary *dict = @{@"id" : self.tagId};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/man_women.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.secondArray = responseObject[@"json_list"];
        
        self.footVModel = [NSArray yy_modelArrayWithClass:[LPPFooterViewModel class] json:responseObject[@"json_list"]];

        self.footVHeight = self.footVModel.count * 180;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
        cell.tagId = self.tagId;
        return cell;
    }else if (indexPath.section == 1){
        LPPRecommendSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRecommendSecondCell" forIndexPath:indexPath];
        if (self.secondArray.count != 0) {
            cell.dataSource = self.secondArray[indexPath.section -1][@"secondList"];
        }
        
        return cell;
    }else{
        LPPRecommendSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPRecommendSecondCell" forIndexPath:indexPath];
        if (self.secondArray.count != 0) {
            cell.dataSource = self.secondArray[indexPath.section -1][@"secondList"];
        }
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
        return self.footVHeight;
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
        [view addSubview:[self setLunBo]];
        return view;
    }else if (section == 1){
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Cloth"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Cloth"];
        }
        if (self.imgView) {
            [self.imgView removeFromSuperview];
        }
        
        if (self.secondArray.count !=0) {
            NSString *secondID = self.secondArray[section -1][@"secondId"];
            
            NSURL *url = [NSURL URLWithString:self.secondArray[section -1][@"secondPhoto"]];
            NSLog(@"++%@\n---%@",secondID,url);
            [self.imgView sd_setImageWithURL:url placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
        }

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
        
        if (self.secondArray.count !=0) {
            NSString *secondID = self.secondArray[section -1][@"secondId"];
            
            NSURL *url = [NSURL URLWithString:self.secondArray[section -1][@"secondPhoto"]];
            NSLog(@"++%@\n---%@",secondID,url);
            [self.imgView2 sd_setImageWithURL:url placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
        }
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
        footView.modelArr = self.footVModel ;
        footView.count = self.footVModel.count;
        
        return footView;
    }
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-104-30) style:UITableViewStyleGrouped];
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

- (ATCarouselView *)setLunBo{
    if (_carouselView) {
        [_carouselView removeFromSuperview];
    }
    _carouselView = [[ATCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _carouselView.delegate = self;
    _carouselView.images = [self.imgArray copy];
    //当前选中颜色
    _carouselView.currentPageColor = [UIColor blackColor];
    //普通状态颜色
    _carouselView.pageColor = [UIColor lightGrayColor];
    return _carouselView;
}

@end
