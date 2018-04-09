//
//  LPPSecondCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPSecondCollectionCell.h"

@implementation LPPSecondCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setModel:(LPPSecondCellModel *)model{
    _model = model;
    self.goodsNameLabel.text = model.goodName;
    if (model.goodPrice.length != 0) {
        self.goodsPriceLabel.text = [@"￥" stringByAppendingString:model.goodPrice];
    }
    //
    NSURL *imageUrl = [NSURL URLWithString:model.goodsPhoto];
    [self.imgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
