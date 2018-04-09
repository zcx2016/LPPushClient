//
//  LPPRecommendSecondCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRecommendSecondCell.h"
#import "LPPSecondCollectionCell.h"
#import "LPPSecondCellModel.h"
#import "LPPCommodityDetailVC.h"

@interface LPPRecommendSecondCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

//3级大图数组
@property (nonatomic, strong) NSArray <LPPSecondCellModel *>*cellArray;

@end

@implementation LPPRecommendSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"data===%@",self.dataSource);
    if (self.dataSource.count!=0) {
        _cellArray = [NSArray yy_modelArrayWithClass:[LPPSecondCellModel class] json:self.dataSource];
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
    
    LPPSecondCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPSecondCollectionCell" forIndexPath:indexPath] ;
    LPPSecondCellModel *model = _cellArray[indexPath.item];
    cell.model = model;
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

#pragma mark - 点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommodityDetailVC * vc = [LPPCommodityDetailVC new];
    LPPSecondCellModel *model = _cellArray[indexPath.item];
    vc.deliverID = model.goodId;
    [[self viewController].navigationController pushViewController:vc animated:YES];
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

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
