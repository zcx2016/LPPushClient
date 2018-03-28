//
//  LPPMyAccountCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyAccountCell.h"

@implementation LPPMyAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = ZCXColor(241, 243, 248);
    self.sonView.layer.cornerRadius = 5;
    self.sonView.layer.masksToBounds = YES;
    
    //头像变圆形
    self.headIcon.layer.cornerRadius = 30;
    self.headIcon.layer.masksToBounds = YES;
}

@end
