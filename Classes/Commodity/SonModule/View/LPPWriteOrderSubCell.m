//
//  LPPWriteOrderSubCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWriteOrderSubCell.h"

@implementation LPPWriteOrderSubCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(LPPWriteOrderModel *)model{
    _model = model;
    self.nameLabel.text = model.goods_name;
    if (model.goods_count.length !=0) {
        self.countLabel.text = [@"数量x" stringByAppendingString:model.goods_count];
    }
    if (model.goods_price.length != 0) {
        self.priceLabel.text = [@"￥" stringByAppendingString:model.goods_price];
    }
    self.sizeLabel.text = model.goods_gsp_val;
    NSURL *imageUrl = [NSURL URLWithString:model.goods_image];
    [self.commodityImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
@end
