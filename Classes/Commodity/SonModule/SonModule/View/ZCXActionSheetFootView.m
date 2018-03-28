//
//  ZCXActionSheetFootView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetFootView.h"

@implementation ZCXActionSheetFootView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.outView.backgroundColor = ZCXColor(247, 244, 244);
//    self.outView.layer.cornerRadius = 5;
//    self.outView.layer.masksToBounds = YES;

}

@end
