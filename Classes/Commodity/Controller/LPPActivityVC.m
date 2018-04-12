//
//  LPPActivityVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPActivityVC.h"
#import "LPPCommodityCell.h"
#import "LPPCommodityDetailVC.h"
#import "LPPActivityHeadView.h"
#import "LPPActivityHeadModel.h"

@interface LPPActivityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <LPPActivityHeadModel *>*dataSource;
@end

@implementation LPPActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionView];
    
    [self loadData];
}

- (void)loadData{
    self.tagId = @"3";
    NSDictionary *dict = @{@"id" : self.tagId};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/activity_new_goods.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr1 = responseObject[@"json_list"];
        NSArray *arr2 = [NSArray array];
        for (NSDictionary *dict in arr1) {
            arr2 = dict[@"firstList"];
        }
        self.dataSource = [NSArray yy_modelArrayWithClass:[LPPActivityHeadModel class] json:arr2];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource objectAtIndex:section].secondList.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPCommodityCell" forIndexPath:indexPath] ;
    
    LPPActivityModel *model = [[self.dataSource objectAtIndex:indexPath.section].secondList objectAtIndex:indexPath.row];
    cell.model = model;
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

#pragma mark - 自定义headView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityDetailVC *detailVc = [LPPCommodityDetailVC new];
    LPPActivityModel *model = [[self.dataSource objectAtIndex:indexPath.section].secondList objectAtIndex:indexPath.row];
    detailVc.deliverID = model.goodId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LPPActivityHeadView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LPPActivityHeadView" forIndexPath:indexPath];

        LPPActivityHeadModel *model = [self.dataSource objectAtIndex:indexPath.section];
        
        reusableView.headModel = model;
        return reusableView;
    }
    return nil;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-150) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册头视图--代码注册
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPActivityHeadView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LPPActivityHeadView"];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPCommodityCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPCommodityCell"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
