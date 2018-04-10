//
//  LPPGoodsListVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPGoodsListVC.h"
#import "LPPCommodityCell.h"
#import "LPPCommodityDetailVC.h"
#import "LPPGoodsListModel.h"

@interface LPPGoodsListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LPPGoodsListModel *> *dataSource;

@end

@implementation LPPGoodsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"商品列表";
    
    [self collectionView];
    [self loadData];
}

- (void)loadData{
    NSDictionary *dict = @{@"id" : self.tagID};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/recommend_big_photo_all_goods.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-列表responseObject---%@",responseObject);
        NSArray *arr1 = responseObject[@"json_list"];
        NSArray *arr2 = [NSArray array];
        for (NSDictionary *dict in arr1) {
            arr2 = dict[@"secondList"];
        }
        NSLog(@"arr2---%@",arr2);
        self.dataSource = [NSArray yy_modelArrayWithClass:[LPPGoodsListModel class] json:arr2];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPCommodityCell" forIndexPath:indexPath] ;
    LPPGoodsListModel *model = self.dataSource[indexPath.row];
    cell.goodsListModel = model;
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 15, 0, 10);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(105, 180);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityDetailVC *detailVc = [LPPCommodityDetailVC new];
    LPPGoodsListModel *model = self.dataSource[indexPath.item];
    detailVc.deliverID = model.goodId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPCommodityCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPCommodityCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end
