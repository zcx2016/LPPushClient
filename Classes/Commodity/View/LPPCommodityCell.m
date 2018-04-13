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
    
    if (model.currentPrice.length !=0) {
        _goodsPriceLabel.text = [@"￥" stringByAppendingString:model.currentPrice];
    }
    
    if (model.goodPrice.length !=0) {
        _goodsOldPriceLabel.text = [@"￥" stringByAppendingString:model.goodPrice];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:model.goodsPhoto];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setLadyManModel:(LPPLadyCommodityModel *)ladyManModel{
    _ladyManModel = ladyManModel;
    _goodsNameLabel.text = ladyManModel.goods_name;
    
    if (ladyManModel.current_price.length !=0) {
        _goodsPriceLabel.text = [@"￥" stringByAppendingString:ladyManModel.current_price];
    }
    
    if (ladyManModel.goods_price.length !=0) {
        _goodsOldPriceLabel.text = [@"￥" stringByAppendingString:ladyManModel.goods_price];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:ladyManModel.goods_image];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setGoodsListModel:(LPPGoodsListModel *)goodsListModel{
    _goodsListModel = goodsListModel;
    _goodsNameLabel.text = goodsListModel.goodName;

    if (goodsListModel.currentPrice.length !=0) {
        _goodsPriceLabel.text = [@"￥" stringByAppendingString:goodsListModel.currentPrice];
    }
    
    if (goodsListModel.goodPrice.length !=0) {
        _goodsOldPriceLabel.text = [@"￥" stringByAppendingString:goodsListModel.goodPrice];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:goodsListModel.goodsPhoto];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
@end
