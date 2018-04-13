//
//  LPPBuyNowOrderCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPBuyNowOrderCell.h"

@implementation LPPBuyNowOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineView.hidden = YES;
    //设置 加减 view
    self.changeCountView.layer.cornerRadius = 14;
    self.changeCountView.layer.masksToBounds = YES;
    self.changeCountView.layer.borderWidth = 1;
    self.changeCountView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - 按钮点击事件
- (void)addBtnClick:(UIButton *)btn{
    NSInteger a = [self.changeCountLabel.text integerValue];
    a++;
    self.changeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)a];
    self.countLabel.text = [@"数量x" stringByAppendingString:self.changeCountLabel.text];
//    if ([self.delegate respondsToSelector:@selector(adjustGoodsNum:Count:)]) {
//        [self.delegate adjustGoodsNum:btn Count:a];
//    }
}

- (void)reduceBtnClick:(UIButton *)btn{
    NSInteger a = [self.changeCountLabel.text integerValue];
    if (a>1) {
        a--;
        self.changeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)a];
        self.countLabel.text = [@"数量x" stringByAppendingString:self.changeCountLabel.text];
//        if ([self.delegate respondsToSelector:@selector(adjustGoodsNum:Count:)]) {
//            [self.delegate adjustGoodsNum:btn Count:a];
//        }
    }
}

@end
