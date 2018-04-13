//
//  LPPCDComparePriceCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDComparePriceCell.h"
#import "LPPSizeListModel.h"
#import "LPPSizeCollectionCell.h"

@interface LPPCDComparePriceCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LPPSizeListModel *>*dataSource;
@end

@implementation LPPCDComparePriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.dataSource = [NSArray yy_modelArrayWithClass:[LPPSizeListModel class] json:self.dataArray];
    if (self.dataSource.count != 0) {
        [self.collectionView reloadData];
    }
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
    LPPSizeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPSizeCollectionCell" forIndexPath:indexPath];
    LPPSizeListModel *model = self.dataSource[indexPath.item];
    cell.model = model;
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPSizeListModel *model = self.dataSource[indexPath.item];
    NSLog(@"ID======%@",model.id);
    //回调商品规格接口
    if ([self.delegate respondsToSelector:@selector(reloadGoodsUIWithSizeId:)]) {
        [self.delegate reloadGoodsUIWithSizeId:model.id];
    }
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 30);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPSizeCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPSizeCollectionCell"];
        
        [self.sizeListView addSubview:_collectionView];
    }
    return _collectionView;
}

@end
