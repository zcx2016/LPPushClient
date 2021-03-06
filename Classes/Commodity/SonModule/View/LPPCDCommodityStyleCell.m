//
//  LPPCDCommodityStyleCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDCommodityStyleCell.h"
#import "LPPCDCardCollectionCell.h"
#import "LPPColorListModel.h"

@interface LPPCDCommodityStyleCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LPPColorListModel *>*dataSource;
@end

@implementation LPPCDCommodityStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.dataSource = [NSArray yy_modelArrayWithClass:[LPPColorListModel class] json:self.dataArray];
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
    LPPCDCardCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPCDCardCollectionCell" forIndexPath:indexPath] ;
    LPPColorListModel *model = self.dataSource[indexPath.item];
    cell.colorListModel = model;
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPColorListModel *model = self.dataSource[indexPath.item];
    NSLog(@"id-----%@",model.colorid);
    if ([self.delegate respondsToSelector:@selector(reloadGoodsUIWithColorId:)]) {
        [self.delegate reloadGoodsUIWithColorId:model.colorid];
    }
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 0, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(140, 180);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPCDCardCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPCDCardCollectionCell"];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


@end
