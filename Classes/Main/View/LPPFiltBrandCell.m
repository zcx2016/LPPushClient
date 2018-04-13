//
//  LPPFiltBrandCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPFiltBrandCell.h"
#import "LPPBrandCollectionCell.h"

@interface LPPFiltBrandCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LPPFiltBrandCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setCollectionView];
    [self.collectionView reloadData];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.brandListArray.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPBrandCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPBrandCollectionCell" forIndexPath:indexPath] ;
    if(self.brandListArray.count != 0 ){
        [cell.brandLabel setText:self.brandListArray[indexPath.item]];
    }
    
    return cell;
}

//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.brandListArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(pickBrand:)]) {
        [self.delegate pickBrand:str];
    }
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(55, 40);
}

- (void)setCollectionView{
    if (_collectionView) {
        [_collectionView removeFromSuperview];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth/6*5-40, self.brandHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"LPPBrandCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPBrandCollectionCell"];
    
    [self addSubview:_collectionView];
}

@end
