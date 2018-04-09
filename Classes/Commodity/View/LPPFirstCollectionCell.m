//
//  LPPFirstCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPFirstCollectionCell.h"


@implementation LPPFirstCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.contentView.backgroundColor = ZCXColor(238, 235, 235);
}

- (void)setModel:(LPPFirstCellModel *)model{
    
    _model = model;
    self.goodsNameLabel.text = model.secondName;
    //
    NSURL *imageUrl = [NSURL URLWithString:model.secondPhoto];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];

}

@end
