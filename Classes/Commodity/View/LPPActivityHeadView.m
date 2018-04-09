//
//  LPPActivityHeadView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPActivityHeadView.h"

@implementation LPPActivityHeadView

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setHeadModel:(LPPActivityHeadModel *)headModel{
    _headModel = headModel;
    _titleLabel.text = headModel.secondName;
}

@end
