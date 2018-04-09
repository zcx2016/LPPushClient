//
//  LPPRecommendFirstCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRecommendFirstCell.h"
#import "LPPFirstCollectionCell.h"
#import "LPPGoodsListVC.h"
//model
#import "LPPFirstCellModel.h"

@interface LPPRecommendFirstCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

//2级小图数组
@property (nonatomic, strong) NSArray *firstCellArray;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation LPPRecommendFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self collectionView];
    [self loadFirstCellData];
}

- (void)loadFirstCellData{
    self.tagId = @"1";
    NSDictionary *dict = @{@"id" : self.tagId};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/recommend_small_photo.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.firstCellArray = [NSArray yy_modelArrayWithClass:[LPPFirstCellModel class] json:responseObject[@"json_list"]];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.firstCellArray.count;
}

#pragma  mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LPPFirstCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPPFirstCollectionCell" forIndexPath:indexPath] ;
    LPPFirstCellModel *model = self.firstCellArray[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPPGoodsListVC *vc = [LPPGoodsListVC new];
    LPPFirstCellModel *model = self.firstCellArray[indexPath.item];
    vc.tagID = model.secondId;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 1, 10, 1);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(200, 90);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册headView
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LPPFirstCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LPPFirstCollectionCell"];
        
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
