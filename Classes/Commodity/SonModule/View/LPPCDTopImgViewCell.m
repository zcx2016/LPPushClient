//
//  LPPCDTopImgViewCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDTopImgViewCell.h"

@interface LPPCDTopImgViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation LPPCDTopImgViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imgArray.count!=0) {
        NSString *str = [NSString stringWithFormat:@"%ld" , self.imgArray.count];
        [self.tagBtn setTitle:[@"1/" stringByAppendingString:str] forState:UIControlStateNormal];
        [self.collectionView reloadData];
    }
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArray.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imgCell" forIndexPath:indexPath];
    //图片
    UIImageView *imgView = [UIImageView new];
    if (self.imgArray.count != 0) {
        NSURL *url = [NSURL URLWithString:self.imgArray[indexPath.item]];
        [imgView sd_setImageWithURL:url placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    
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

#pragma mark - 计算当前页数
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    self.pageIndex = targetContentOffset->x / kScreenWidth +1;
    NSString *current = [NSString stringWithFormat:@"%ld" , self.pageIndex];
    NSString *sum = [NSString stringWithFormat:@"%ld" , self.imgArray.count];
    [self.tagBtn setTitle:[[current stringByAppendingString:@"/"] stringByAppendingString:sum] forState:UIControlStateNormal];
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

        [self addSubview:_collectionView];
    }
    return _collectionView;
}


@end
