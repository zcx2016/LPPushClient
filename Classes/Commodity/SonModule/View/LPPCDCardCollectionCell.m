//
//  LPPCDCardCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDCardCollectionCell.h"

@implementation LPPCDCardCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.layer.cornerRadius  = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setColorListModel:(LPPColorListModel *)colorListModel{
    _colorListModel = colorListModel;
    self.colorLabel.text = colorListModel.value;
    //
    NSURL *imageUrl = [NSURL URLWithString:colorListModel.getColorOne];
    [self.goodsImgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.backgroundColor = selected? [UIColor yellowColor] :[UIColor whiteColor];
}
@end
