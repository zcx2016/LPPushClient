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

@end
