//
//  LPPCommodityCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCommodityCell.h"

@implementation LPPCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setModel:(LPPActivityModel *)model{
    _model = model;
    _goodsNameLabel.text = model.goodId;
    _goodsPriceLabel.text = model.currentPrice;
    _goodsOldPriceLabel.text = model.goodPrice;
    
    NSURL *imageUrl = [NSURL URLWithString:model.goodsPhoto];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setLadyManModel:(LPPLadyCommodityModel *)ladyManModel{
    _ladyManModel = ladyManModel;
    _goodsNameLabel.text = ladyManModel.goods_name;
    _goodsPriceLabel.text = ladyManModel.current_price;
    _goodsOldPriceLabel.text = ladyManModel.goods_price;
    
    NSURL *imageUrl = [NSURL URLWithString:ladyManModel.goods_image];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setGoodsListModel:(LPPGoodsListModel *)goodsListModel{
    _goodsListModel = goodsListModel;
    _goodsNameLabel.text = goodsListModel.goodName;
    _goodsPriceLabel.text = goodsListModel.currentPrice;
    _goodsOldPriceLabel.text = goodsListModel.goodPrice;
    
    NSURL *imageUrl = [NSURL URLWithString:goodsListModel.goodsPhoto];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
@end
