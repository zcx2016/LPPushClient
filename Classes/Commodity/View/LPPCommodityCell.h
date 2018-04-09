//
//  LPPCommodityCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPActivityModel.h"
#import "LPPLadyCommodityModel.h"
#import "LPPGoodsListModel.h"

@interface LPPCommodityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsOldPriceLabel;

@property (nonatomic, strong) LPPActivityModel *model;

@property (nonatomic, strong) LPPLadyCommodityModel *ladyManModel;

@property (nonatomic, strong) LPPGoodsListModel *goodsListModel;

@end
