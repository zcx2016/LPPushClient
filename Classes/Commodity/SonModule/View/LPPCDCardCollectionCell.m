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

@end
