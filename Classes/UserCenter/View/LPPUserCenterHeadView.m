//
//  LPPUserCenterHeadView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUserCenterHeadView.h"

@implementation LPPUserCenterHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //userCenter_bg
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userCenter_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.contentView.layer.contents = (id)image.CGImage;
}

@end
