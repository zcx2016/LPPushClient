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

@interface LPPActivityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *activityTitleLabel;
@end

@implementation LPPActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self collectionView];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPCommodityCell" forIndexPath:indexPath] ;
//    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 15, 0, 10);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(105, 210);
}

#pragma mark - 自定义headView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityDetailVC *detailVc = [LPPCommodityDetailVC new];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LPPActivityHeadView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LPPActivityHeadView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            reusableView.titleLabel.text = @"活动1";
        }else{
            reusableView.titleLabel.text = @"活动2";
        }
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
