//
//  LPPGoodsHomeVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/11.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPGoodsHomeVC.h"
#import "LPPGoodsTitleCell.h"
#import "LPPGoodsTitleModel.h"

@interface LPPGoodsHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <LPPGoodsTitleModel *>*bannerDataSource;

@end

@implementation LPPGoodsHomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionView];
    
    [self loadBannerData];
}

- (void)loadBannerData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"port_name" : @"PUSHING" , @"user_id" : user_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/index_banner.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"banner--responseObject--%@",responseObject);
        
        self.bannerDataSource = [NSArray yy_modelArrayWithClass:[LPPGoodsTitleModel class] json:responseObject[@"json_list"]];
        
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"banner-error--%@",error);
    }];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerDataSource.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LPPGoodsTitleCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPGoodsTitleCell" forIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor greenColor];
    LPPGoodsTitleModel *model = self.bannerDataSource[indexPath.item];
    cell.model = model;
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    LPPGoodsListVC *vc = [LPPGoodsListVC new];
//    LPPFirstCellModel *model = self.firstCellArray[indexPath.item];
//    vc.tagID = model.secondId;
//    [[self viewController].navigationController pushViewController:vc animated:YES];
//}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 0, 0);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 40);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;

        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPGoodsTitleCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPGoodsTitleCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
