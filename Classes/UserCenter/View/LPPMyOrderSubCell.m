//
//  LPPMyOrderSubCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderSubCell.h"

@implementation LPPMyOrderSubCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(LPPMyOrderSonModel *)model{
    _model = model;
    _nameLabel.text = model.goods_name;
    _sizeLabel.text = model.goods_gsp_val;
    if (model.goods_count.length != 0) {
        _countLabel.text = [@"数量x" stringByAppendingString:model.goods_count];
    }
    if (model.goods_price.length != 0) {
        _priceLabel.text = [@"￥" stringByAppendingString:model.goods_price];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:model.goods_image];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
//
//    if (goodsNumLabel) {
//        <#statements#>
//    }

}

@end
