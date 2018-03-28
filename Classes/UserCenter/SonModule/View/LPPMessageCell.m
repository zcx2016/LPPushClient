//
//  LPPMessageCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMessageCell.h"

@implementation LPPMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.outView.layer.borderWidth = 1;
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.masksToBounds = YES;
}


@end
