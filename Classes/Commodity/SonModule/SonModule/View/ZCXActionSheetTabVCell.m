//
//  ZCXActionSheetTabVCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetTabVCell.h"
#import "ZCXActionSheetCell.h"

@interface ZCXActionSheetTabVCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZCXActionSheetTabVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self collectionView];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZCXActionSheetCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCXActionSheetCell" forIndexPath:indexPath] ;
    cell.backgroundColor = ZCXColor(248, 244, 243);
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 1, 5, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(105, 95);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
                _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = ZCXColor(248, 244, 243);
        //         _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ZCXActionSheetCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ZCXActionSheetCell"];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end
