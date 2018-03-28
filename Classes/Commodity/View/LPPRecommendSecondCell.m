//
//  LPPRecommendSecondCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRecommendSecondCell.h"
#import "LPPSecondCollectionCell.h"

@interface LPPRecommendSecondCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LPPRecommendSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self collectionView];
//    self.backgroundColor = [UIColor purpleColor];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LPPSecondCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPSecondCollectionCell" forIndexPath:indexPath] ;
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 1, 10, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(120, 160);
}


#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPSecondCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPSecondCollectionCell"];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


@end
