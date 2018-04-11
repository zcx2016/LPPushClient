//
//  LPPOtherCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPOtherCollectionCell.h"

@implementation LPPOtherCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.contentView.backgroundColor = ZCXColor(230, 230, 230);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
        self.contentView.backgroundColor = selected ? [UIColor colorWithPatternImage:[UIImage imageNamed:@"colorBtn"]] : ZCXColor(230, 230, 230);
}


@end
