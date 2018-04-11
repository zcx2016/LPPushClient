//
//  LPPBrandCollectionCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPBrandCollectionCell.h"

@implementation LPPBrandCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.contentView.backgroundColor = selected ? [UIColor colorWithPatternImage:[UIImage imageNamed:@"colorBtn"]] : [UIColor clearColor];
}

@end
