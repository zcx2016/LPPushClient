//
//  LPPFiltCategoryCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPFiltCategoryCell.h"
#import "LPPOtherCollectionCell.h"

@interface LPPFiltCategoryCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LPPFiltCategoryCell

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
    return self.classListArray.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPOtherCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPOtherCollectionCell" forIndexPath:indexPath] ;
    if(self.classListArray.count != 0 ){
        [cell.typeBtn setTitle:self.classListArray[indexPath.item] forState:UIControlStateNormal];
    }
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 40);
}

- (void)setCollectionView{
    if (_collectionView) {
        [_collectionView removeFromSuperview];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth/6*5-40, self.classHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"LPPOtherCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPOtherCollectionCell"];
    
    [self addSubview:_collectionView];
}



@end
