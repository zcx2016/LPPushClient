//
//  LPPCDTopImgViewCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDTopImgViewCell.h"

@interface LPPCDTopImgViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LPPCDTopImgViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self collectionView];
    
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imgCell" forIndexPath:indexPath];
    //图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bag"]];
    imgView.frame =CGRectMake((kScreenWidth - 240)/2, 10, 200, 200);
    [cell addSubview:imgView];
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 0, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth, 200);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled  = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imgCell"];
//        [_collectionView registerNib:[UINib nibWithNibName:@"imgCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"imgCell"];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


@end